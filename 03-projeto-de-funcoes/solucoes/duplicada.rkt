#lang racket

(require examples)

;; String -> Boolean
;;
;; Produz #t se palavra é duplicada, isto é, é formada pela ocorrência
;; de duas partes iguais separadas ou não por hífen. Devolve #f se
;; palavra não é duplicada.

(examples
  (check-equal? (duplicada? "xixi") #t)
  (check-equal? (duplicada? "lero-lero") #t)
  (check-equal? (duplicada? "aba") #f)
  (check-equal? (duplicada? "ab-ba") #f))

(define (duplicada? palavra)
  (define tam (string-length palavra))
  (define meio (quotient tam 2))
  (or (and (even? tam)
           (equal? (substring palavra 0 meio)
                   (substring palavra meio)))
      (and (odd? tam)
           (equal? (substring palavra meio (add1 meio))
                   "-")
           (equal? (substring palavra 0 meio)
                   (substring palavra (add1 meio))))))
