#lang racket

(require examples)

; Análise
;
; Deixar todas as strings de uma lista com o mesmo tamanho,
; adiciona espaços no final das strings se necessário.

(examples
 (check-equal? (ajusta-tamanho (list "São Paulo"
                                     "Maringá"
                                     "Londrina"))
               (list "São Paulo"
                     "Maringá  "
                     "Londrina ")))

;; Lista(String) -> Lists(String)
;;
;; Produz uma nova lista ajustanto os elementos de lst
;; para que eles fiquem com o mesmo número de caracteres.
;; As strings que têm os maiores tamanho permanecem
;; inalteradas, para as demais, espaços em branco são
;; adicionados no final.
(define (ajusta-tamanho lst)
  (define tam
    (foldr max 0 (map string-length lst)))
  (define (espacos-faltanto s)
    (make-string (- tam (string-length s)) #\space))
  (define (ajusta s)
    (string-append s (espacos-faltanto s)))
  (map ajusta lst))
