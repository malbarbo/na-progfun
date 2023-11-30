#lang racket

(require examples)

;;;;;;;
;; Tipos de dados

;; Alinhamento é um dos valores
;; - "direita"
;; - "esquerda"
;; - "centro"


;; String Number Alinhamento -> String
;;
;; Produz uma nova string a partir de s que tem exatamente num-chars caracteres
;; e é alinhada de acordo com o alinhamento.
;;
;; Se s tem exatamente num-chars caracteres, então produz s.
;;
;; Se s tem mais do que num-chars caracteres, então s é truncada e ...
;; é adicionado ao final para sinalizar que a string foi abreviada.
;;
;; Se s tem menos do que num-chars caracteres, então espaços são
;; adicionados no início se alinhamento é "esquerda", no fim
;; se alinhamento é "direita", ou no ínicio e fim se alinhamento
;; e "centro". Nesse último caso, se a quantidade de espaços adicionados
;; for impar, então no fim será adicionado 1 espaço a mais do que no início.
(examples
 ; (= (string-length s) num-chars)
 (check-equal? (ajusta-string "casa" 4 "direita") "casa")
 (check-equal? (ajusta-string "casa" 4 "esquerda") "casa")
 (check-equal? (ajusta-string "casa" 4 "centro") "casa")

 ; (> (string-length s) num-chars)
 ; (string-append (substring "casa verde" 0 (- 7 3)) "...")
 (check-equal? (ajusta-string "casa verde" 7 "direita") "casa...")
 (check-equal? (ajusta-string "casa verde" 7 "esquarda") "casa...")
 (check-equal? (ajusta-string "casa verde" 7 "centro") "casa...")
 (check-equal? (ajusta-string "casa verde" 9 "direita") "casa v...")

 ; (<= (string-length s) num-chars)
 ; direita
 ; (string-append (make-string (- 9 (string-length "casa")) #\space)
 ;                             "casa")
 (check-equal? (ajusta-string "casa" 9 "direita") "     casa")

 ; esquerda
 ; (string-append (make-string "casa"
 ;                             (- 9 (string-length "casa")) #\space))
 (check-equal? (ajusta-string "casa" 9 "esquerda") "casa     ")

 ; centro
 ; (define num-espacos-inicio (quotient (- num-chars (string-length "casa)) 2)
 ; (define num-espacos-fim (- num-chars (string-length "casa)
 ;                            num-espacos-inicio)
 ; (string-append
 ;   (make-string num-espacos-inicio #\space))
 ;   "centro"
 ;   (make-string num-espacos-fim #\space))
 (check-equal? (ajusta-string "casa" 9 "centro") "  casa   ")
 (check-equal? (ajusta-string "casa" 10 "centro") "   casa   "))

(define (ajusta-string s num-chars alinhamento)
  (cond
    [(= (string-length s) num-chars)
     s]
    [(> (string-length s) num-chars)
     (string-append (substring s 0 (- num-chars 3)) "...")]
    [else
     (define num-espacos (- num-chars (string-length s)))
     (cond
       [(equal? alinhamento "direita")
        (string-append (make-string num-espacos #\space) s)]
       [(equal? alinhamento "esquerda")
        (string-append s (make-string num-espacos #\space))]
       [else
        (define num-espacos-inicio (quotient num-espacos 2))
        (define num-espacos-fim (- num-espacos num-espacos-inicio))
        (string-append
         (make-string num-espacos-inicio #\space)
         s
         (make-string num-espacos-fim #\space))])]))
