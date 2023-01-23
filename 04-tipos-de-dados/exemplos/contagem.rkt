#lang racket

(require examples)

(struct contagem (verde vermelho azul branco) #:transparent)
;; Uma contagem das respostas de cada cor
;;   verde: Número - número de respostas verde
;;   vermelho: Número - número de respostas vermelho
;;   azul: Número - número de respostas azul
;;   branco: Número - número de respostas branco

;; Resposta é um dos valores
;; - "verde"
;; - "vermelho"
;; - "azul"
;; - "branco"

;; Especificação

;; Resposta Contagem -> Contagem
;; Atualiza a contagem cont adicionando a resposta res.
(examples
 (check-equal? (atualiza-contagem "verde" (contagem 4 5 1 2))
               (contagem 5 5 1 2));; (struct-copy contagem (contagem 4 5 1 2)
                                  ;;              [verde (add1 (contagem-verde (contagem 4 5 1 2)))])
 (check-equal? (atualiza-contagem "vermelho" (contagem 4 5 1 2))
               (contagem 4 6 1 2))
 (check-equal? (atualiza-contagem "azul" (contagem 4 5 1 2))
               (contagem 4 5 2 2))
 (check-equal? (atualiza-contagem "branco" (contagem 4 5 1 2))
               (contagem 4 5 1 3)))

(define (atualiza-contagem res cont)
  (cond
    [(equal? res "verde")
     (struct-copy contagem
                  cont [verde (add1 (contagem-verde cont))])]
    [(equal? res "vermelho")
     (struct-copy contagem
                  cont [vermelho (add1 (contagem-vermelho cont))])]
    [(equal? res "azul")
     (struct-copy contagem
                  cont [azul (add1 (contagem-azul cont))])]
    [(equal? res "branco")
     (struct-copy contagem
                  cont [branco (add1 (contagem-branco cont))])]))
