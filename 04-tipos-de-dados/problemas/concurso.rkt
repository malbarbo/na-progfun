#lang racket

(require examples)

; Análise
;
; - Determinar o candidado melhor classificado entre dois candidados
; - A classificação é feita pelos pontos (0 a 100), mais pontos fica
;   na frente, seguido pelo menor número de inscrição (que é único).
;
; Definição de tipos de dados
;
; - Vamos representar um candidado com um estruda com nome, inscrição e pontos.
; - Vamos assumir que a inscrição é um número natural.

(struct candidado (inscricao nome pontos) #:transparent)
;; Representa um candidado em um concurso
;; - nome: string
;; - inscricao: natural
;; - pontos: natutal de 0 a 100

;; Candidado Candidado -> Candidado
;; Determina qual dos candidos, a ou b, ficou melhor classificado.
;; A classificação é determinada pelo maior número de pontos, e se houver
;; empate pelo menor número de inscrição.

(examples
  ; Candido a melhor classificado que b
  (check-equal? (melhor-classificado (candidado 4 "João" 80)
                                     (candidado 5 "Pedro" 70))
                (candidado 4 "João" 80))
  (check-equal? (melhor-classificado (candidado 4 "João" 70)
                                     (candidado 5 "Pedro" 70))
                (candidado 4 "João" 70))
  ; Candido b melhor classificado que a
  (check-equal? (melhor-classificado (candidado 4 "João" 70)
                                     (candidado 5 "Pedro" 80))
                (candidado 5 "Pedro" 80))
  (check-equal? (melhor-classificado (candidado 4 "João" 70)
                                     (candidado 3 "Pedro" 70))
                (candidado 3 "Pedro" 70)))

(define (melhor-classificado a b)
  (if (or (> (candidado-pontos a) (candidado-pontos b))
          (and (= (candidado-pontos a) (candidado-pontos b))
               (< (candidado-inscricao a) (candidado-inscricao b))))
    a
    b))
