#lang racket

(require examples)

;; Estado é um dos valores
;; - "aberto"
;; - "fechado"
;; - "com-bandeira"

(struct quadrado (mina? estado) #:transparent)
;; Representa um quadrado no jogo campo minado
;;  mina? : Bool - #t se tem uma mina no quadrado, #f caso contrário
;;  estado: Estado - o estado do quadrado

;; Quadrado Acao -> Acao
;;
;; Atualiza o estado do quadrado q dado a acao do usuário.
;; A atualização é feita conforme a tabela a seguir, onde
;; - significa que o quadrado permanece como estava.
;;
;; | estado/ação  |     abrir      |   adicionar    |   remover     |
;; |-------------:|:--------------:|:--------------:|:-------------:|
;; | aberto       |      -         |       -        |      -        |
;; | fechado      |    aberto      | com-bandeira   |      -        |
;; | com-bandeira |      -         |       -        |   fechado     |
;;
(examples
  ; aberto
  (check-equal? (atualiza-quadrado (quadrado #f "aberto") "abrir")
                (quadrado #f "aberto"))
  (check-equal? (atualiza-quadrado (quadrado #f "aberto") "adicionar-bandeira")
                (quadrado #f "aberto"))
  (check-equal? (atualiza-quadrado (quadrado #f "aberto") "remover-bandeira")
                (quadrado #f "aberto"))
  ; fechado
  ; (struct-copy quadrado q [estado "aberto"])
  (check-equal? (atualiza-quadrado (quadrado #f "fechado") "abrir")
                (quadrado #f "aberto"))
  (check-equal? (atualiza-quadrado (quadrado #f "fechado") "adicionar-bandeira")
                (quadrado #f "com-bandeira"))
  (check-equal? (atualiza-quadrado (quadrado #f "fechado") "remover-bandeira")
                (quadrado #f "fechado"))
  ; com-bandeira
  (check-equal? (atualiza-quadrado (quadrado #f "com-bandeira") "abrir")
                (quadrado #f "com-bandeira"))
  (check-equal? (atualiza-quadrado (quadrado #f "com-bandeira") "adicionar-bandeira")
                (quadrado #f "com-bandeira"))
  (check-equal? (atualiza-quadrado (quadrado #f "com-bandeira") "remover-bandeira")
                (quadrado #f "fechado")))

(define (atualiza-quadrado q acao)
  (define estado (quadrado-estado q))
  (cond
    [(and (equal? estado "fechado")
          (equal? acao "abrir"))
     (struct-copy quadrado q [estado "aberto"])]
    [(and (equal? estado "fechado")
          (equal? acao "adicionar-bandeira"))
     (struct-copy quadrado q [estado "com-bandeira"])]
    [(and (equal? estado "com-bandeira")
          (equal? acao "remover-bandeira"))
     (struct-copy quadrado q [estado "fechado"])]
    [else q]))
