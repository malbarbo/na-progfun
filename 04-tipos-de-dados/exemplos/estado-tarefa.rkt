#lang racket

(require examples)

(struct sucesso (tempo msg))
(struct erro (codigo msg))
;; EstadoTarefa é um dos valores:
;; - "Executando"             A tarefa está em execução
;; - (sucesso Número String)  A tarefa finalizou com sucesso
;; - (erro Número String)     A tarefa finalizou com falha

;; EstadoTarefa -> String
;; Produz uma string amigável para o usuário para descrever o estado da tarefa.
(examples
 (check-equal? (msg-usuario "Executando")
               "A tarefa está em execução.")
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
     (string-append "A tarefa falhou (err "
                    (number->string (erro-codigo estado))
                    "): "
                    (erro-msg estado)
                    ".")]))
