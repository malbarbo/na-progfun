#lang typed/racket

(struct executando () #:transparent)

(struct sucesso
  ([duracao : Number]
   [msg : String]) #:transparent)

(struct erro
  ([codigo : Number]
   [msg : String]) #:transparent)

(define-type EstadoTarefa (U executando sucesso erro))

(: mensagem (-> EstadoTarefa String))
(define (mensagem estado)
  (cond
    [(executando? estado)
     "A tarefa está em execução"]
    [(sucesso? estado)
     (format "A tarefa finalizou com sucesso (~as): ~a."
             (sucesso-duracao estado)
             (sucesso-msg estado))]
    [(erro? estado)
     (format "A tarefa falhou (erro ~a): ~a."
             (erro-codigo estado)
             (erro-msg estado))]))
