#lang racket

(require examples)

;; ListaDeStrings -> String
;; Produz uma string juntando os elementos de lst da seguinte forma:
;; Se a lista é vazia, devolve "".
;; Se a lista tem apenas um elemento, devolve esse elemento.
;; Senão, junta as strings de lst, separando-as com ", ", com exceção
;; da última string, que é separada com " e ".

(examples
  (check-equal? (junta-virgula-e empty) "")
  (check-equal? (junta-virgula-e (list "maça")) "maça")
  (check-equal? (junta-virgula-e (list "mamão" "banana" "maça"))
                "mamão, banana e maça")
  (check-equal? (junta-virgula-e (list "aveia" "mamão" "banana" "maça"))
                "aveia, mamão, banana e maça"))

(define (junta-virgula-e lst)
  (cond
    [(empty? lst)
     ""]
    [(empty? (rest lst))
     (first lst)]
    [(empty? (rest (rest lst)))
     (string-append (first lst)
                    " e "
                    (second lst))]
    [else
      (string-append (first lst)
                     ", "
                     (junta-virgula-e (rest lst)))]))
