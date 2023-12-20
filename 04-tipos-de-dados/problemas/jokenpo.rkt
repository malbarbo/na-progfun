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


(struct jogada (nome mao))
;; Representa a mao feita por um jogador
;; nome: String - o nome do jogador
;; mao: Mao - o símbolo feito pelo jogador


;; Jogada Jogada -> String
;;
;; Determina o nome do jogador, entre o jogador que fez a jogada a e o jogador
;; que fez a jogada b, que ganhou a rodada do Jokenpô. Se houve empate,
;; devolve "".
