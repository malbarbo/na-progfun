#lang racket

(require examples)

; Análise
;
; Determinar o nome do ganhador em uma rodada de Jokenpô entre dois jogadores.
; - Cada jogador pode fazer um dos símbolos com a mão: pedra, papel ou tesoura.
; - A pedra ganha da tesoura, a tesoura ganha do papel, e o papel ganha da pedra.

; Definição dos tipos de dados

;; Mao é um dos valores:
;; - "pedra"
;; - "papel"
;; - "tesoura"


(struct jogada (jogador mao))
;; Representa uma jogada de um jogador no Jokenpô
;; jogador: String - o nome do jogador
;; mao: Mao - o símbolo feito pelo jogador


;; Jogada Jogada -> String
;;
;; Determina o nome do jogador, entre o jogador que fez a jogada a e o jogador
;; que fez a jogada b, que ganhou a rodada do Jokenpô. Se houve empate,
;; devolve "".
;;
;; Para determinar o vencedor as seguintes regras são utilizadas:
;; - Jogada iguais empate
;; - pedra ganha de tesoura
;; - tesoura ganha de papel
;; - papel ganha da pedra
;;
;; a / b   | pedra | papel | tesoura
;; pedra   |   -   |   b   |  a
;; papel   |   a   |   -   |  b
;; tesoura |   b   |   a   |  -
;;
;; Requer que os nomes dos jogadores seram não vazios e diferentes.

(examples
  ; pedra x ...
  (check-equal? (ganhador (jogada "pedro" "pedra")
                          (jogada "paula" "pedra"))
                "")
  (check-equal? (ganhador (jogada "pedro" "pedra")
                          (jogada "paula" "papel"))
                "paula")
  (check-equal? (ganhador (jogada "pedro" "pedra")
                          (jogada "paula" "tesoura"))
                "pedro")
  ; papel x ...
  (check-equal? (ganhador (jogada "pedro" "papel")
                          (jogada "paula" "pedra"))
                "pedro")
  (check-equal? (ganhador (jogada "pedro" "papel")
                          (jogada "paula" "papel"))
                "")
  (check-equal? (ganhador (jogada "pedro" "papel")
                          (jogada "paula" "tesoura"))
                "paula")
  ; tesoura x ...
  (check-equal? (ganhador (jogada "pedro" "tesoura")
                          (jogada "paula" "pedra"))
                "paula")
  (check-equal? (ganhador (jogada "pedro" "tesoura")
                          (jogada "paula" "papel"))
                "pedro")
  (check-equal? (ganhador (jogada "pedro" "tesoura")
                          (jogada "paula" "tesoura"))
                ""))

(define (ganhador a b)
  (cond
    [(equal? (jogada-mao a) (jogada-mao b))
     ""]
    [(or (and (equal? (jogada-mao a) "pedra")
              (equal? (jogada-mao b) "tesoura"))
         (and (equal? (jogada-mao a) "papel")
              (equal? (jogada-mao b) "pedra"))
         (and (equal? (jogada-mao a) "tesoura")
              (equal? (jogada-mao b) "papel")))
     (jogada-jogador a)]
    [else
     (jogada-jogador b)]))

