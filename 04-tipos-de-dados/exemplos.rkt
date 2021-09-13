#lang racket

(require examples)

;; Exemplo: distância

(struct ponto (x y) #:transparent)
;; Ponto representa um ponto no plano cartesiano
;;   x : Número - a coordenada x
;;   y : Número - a coordenada y

;; Ponto -> Número
;; Calcula a distância do ponto p a origem.
(examples
 (check-equal? (distancia-origem (ponto 3 4)) 5))

(define (distancia-origem p)
  (sqrt (+ (sqr (ponto-x p))
           (sqr (ponto-y p)))))


;; Exemplo: classificação retângulo

;; Classificação é um dos valores:
;; - "largo"
;; - "alto"
;; - "quadrado"

(struct retangulo (largura altura) #:transparent)
;; Representa um retangulo
;;   largura : Número - a largura do retangulo
;;   altura  : Número - a altura do retangulo

;; Retangulo -> Classificação
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


;; Exemplo de união

(struct sucesso (tempo msg))
(struct erro (codigo msg))
;; EstadoTarefa é um dos valores:
;; - "Executando"             A tarefa está em execução
;; - (sucesso Número String)  A tarefa finalizou com sucesso
;; - (erro Número String)     A tarefa finalizou com falha

;; EstadoTarefa -> String
;; Produz uma string amigável para o usuário para descrever o estado da tarefa.
(examples
 (check-equal? (msg-usuario "Executando") "A tarefa está em execução.")
 (check-equal? (msg-usuario (sucesso 12 "Os resultados estão corretos"))
               "Tarefa concluída (12s): Os resultados estão corretos.")
 (check-equal? (msg-usuario (erro 123 "Número inválido '12a'"))
               "A tarefa falhou (err 123): Número inválido '12a'."))

(define (msg-usuario estado)
  (cond
    [(and (string? estado) (string=? estado "Executando"))
     "A tarefa está em execução."]
    [(sucesso? estado)
     (string-append "Tarefa concluída ("
                    (number->string (sucesso-tempo estado))
                    "s): "
                    (sucesso-msg estado)
                    ".")]
    [(erro? estado)
     (string-append
      "A tarefa falhou (err "
      (number->string (erro-codigo estado))
      "): "
      (erro-msg estado)
      ".")]))
