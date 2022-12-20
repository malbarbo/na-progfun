#lang racket

(require examples)

;; Exemplo: distância

(struct ponto (x y) #:transparent)
;; Ponto representa um ponto no plano cartesiano
;;   x : Número - a coordenada x
;;   y : Número - a coordenada y

;; Ponto -> Número
;; Calcula a distância do ponto p a origem.
;; A distância de um ponto (x, y) até a origem é calculada
;; pela raiz quadrada de x^2 + y^2.
(examples
 (check-equal? (distancia-origem (ponto 3 4)) 5))

(define (distancia-origem p)
  (sqrt (+ (sqr (ponto-x p))
           (sqr (ponto-y p)))))


;; Exemplo: contagem enquete

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
    [(equal? res "verde") (struct-copy contagem
                                       cont [verde (add1 (contagem-verde cont))])]
    [(equal? res "vermelho") (struct-copy contagem
                                          cont [vermelho (add1 (contagem-vermelho cont))])]
    [(equal? res "azul") (struct-copy contagem
                                      cont [azul (add1 (contagem-azul cont))])]
    [(equal? res "branco") (struct-copy contagem
                                        cont [branco (add1 (contagem-branco cont))])]))



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
