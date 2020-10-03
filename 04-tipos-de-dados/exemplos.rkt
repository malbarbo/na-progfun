#lang racket

(require examples)

;; Exemplo: distância

(struct ponto (x y) #:transparent)
;; Ponto representa um ponto no plano cartesiano
;;   x : Número - a coordenada x
;;   y : Número - a coordenada y
;; Exemplos
#; (define p1 (ponto 3 4))
#; (define p2 (ponto 8 2))
;; Modelo
#;
(define (fn-para-ponto p)
  (... (ponto-x p)
       (ponto-y p)))


;; Ponto -> Número
;; Calcula a distância de um ponto a origem.
(examples
 (check-equal? (distancia-origem (ponto 3 4)) 5))

(define (distancia-origem p)
  (sqrt (+ (sqr (ponto-x p))
           (sqr (ponto-y p)))))


;; Exemplo: classificação retângulo

(struct retangulo (largura altura) #:transparent)
;; Representa um retangulo
;;   largura : Número - a largura do retangulo
;;   altura  : Número - a altura do retangulo
;; Exemplos
#; (define r1 (retangulo 3 4))
#; (define r2 (retangulo 1 2))
;; Modelo
#;
(define (fn-para-retangulo r)
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


;; Exemplo de enumeração

;; Direção é um dos valores:
;; - "Norte"
;; - "Sul"
;; - "Leste"
;; - "Oeste"
;; Interp. a direção em que o personagem está virado.

#;
(define (fn-para-direcao dir)
  (cond [(string=? dir "Norte") (...)]
        [(string=? dir "Sul") (...)]
        [(string=? dir "Leste") (...)]
        [(string=? dir "Oeste") (...)]))

;; Direção -> Direção
;; Calcula a nova direção a partir de dir após virar 90
;; graus no sentido horário.
(examples
 (check-equal? (vira-90 "Norte") "Leste")
 (check-equal? (vira-90 "Leste") "Sul")
 (check-equal? (vira-90 "Sul") "Oeste")
 (check-equal? (vira-90 "Oeste") "Norte"))

; (define (vira-90 dir) "Norte") ; esboço
(define (vira-90 dir)
  (cond [(string=? dir "Norte") "Leste"]
        [(string=? dir "Sul") "Oeste"]
        [(string=? dir "Leste") "Sul"]
        [(string=? dir "Oeste") "Norte"]))


;; Exemplo de união

(struct sucesso (msg tempo))
(struct erro (msg codigo))
;; Mensagem é um dos valores:
;; - ""                       Representa que nenhuma mensagem deve ser exbida
;; - (sucesso String Número)  Representa uma situação de sucesso e o tempo da operação
;; - (erro String Número)     Representa uma situação de erro com o seu código

#;
(define EX-MSG-1 "")
#;
(define EX-MSG-2 (sucesso "Mundaça de preço realizada com sucesso" 23))
#;
(define EX-MSG-3 (erro "Acabou o estoque" 12))

#;
(define (fn-para-mensagem msg)
  (cond [(and (string? msg) (string=? msg "")) (...)]
        [(sucesso? msg) (... (sucesso-msg msg)
                             (sucesso-tempo msg))]
        [(erro? msg) (... (erro-msg msg)
                          (erro-codigo msg))]))

;; Mensagem -> String
;; Produz uma string amigável para o usuário a partir de msg.
;; Se msg for "", produz "".
(examples
 (check-equal? (msg-usuario "") "")
 (check-equal? (msg-usuario (sucesso "Compra de ações" 12))
               "A operação 'Compra de ações' foi realizada com sucesso! (12s)")
 (check-equal? (msg-usuario (erro "Compra de ações" 10))
               "A operação 'Compra de ações' falhou... (erro 10)"))

;(define (msg-usuario msg) ; esboço
;  "")

(define (msg-usuario msg)
  (cond [(and (string? msg) (string=? msg "")) ""]
        [(sucesso? msg) (string-append
                         "A operação '"
                         (sucesso-msg msg)
                         "' foi realizada com sucesso! ("
                         (number->string (sucesso-tempo msg))
                         "s)")]
        [(erro? msg) (string-append
                      "A operação '"
                      (erro-msg msg)
                      "' falhou... (erro "
                      (number->string (erro-codigo msg))
                      ")")]))
