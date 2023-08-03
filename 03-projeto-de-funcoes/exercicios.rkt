#lang racket

(require examples)

;; InteiroPositivo -> Boolean
;;
;; Produz #t se uma pessoa com a idade n é supercentenária,
;; isto é, tem 110 anos ou mais, #f caso contrário.

(examples
 (check-equal? (supercentenario 101) #f)
 (check-equal? (supercentenario 110) #t)
 (check-equal? (supercentenario 112) #t))

(define (supercentenario n)
  (>= n 110))


;; String -> String
;;
;; Transforma a data de entrada do formato "dia/mes/ano"
;; para o formato "ano/mes/dia".
;;
;; Requer que o dia e o mes tenha dois dígitos e que
;; o ano tenha quartro digitos.

(examples
 (check-equal? (data-dma->data-ams "19/07/2023") "2023/07/19")
 (check-equal? (data-dma->data-ams "01/01/1980") "1980/01/01")
 (check-equal? (data-dma->data-ams "02/02/2002") "2002/02/02"))

(define (data-dma->data-ams data)
  (string-append (substring data 6 10)
                 "/"
                 (substring data 3 5)
                 "/"
                 (substring data 0 2)))


;; Tamanho é um dos valores
;; - "curto"
;; - "médio"
;; - "longo"

;; String -> Tamanho
;;
;; Classifica nome de acordo com a quantidade de caracteres da seguinte forma
;; - "curto" para nomes com 4 ou menos caracteres
;; - "longo" para nomes com 10 ou mais caracteres
;; - "médio" para nomes que não são "curto" e nem "longo"

(examples
  (check-equal? (tamanho-nome "Zé") "curto")
  (check-equal? (tamanho-nome "José") "curto")
  (check-equal? (tamanho-nome "Maria") "médio")
  (check-equal? (tamanho-nome "Sebastiana") "médio")
  (check-equal? (tamanho-nome "Constantino") "longo"))

(define (tamanho-nome nome)
  (cond
    [(<= (string-length nome) 4) "curto"]
    [(<= (string-length nome) 10) "médio"]
    [else "longo"]))


;; String -> InteiroPositivo
;;
;; Calcula um número decimal equivalente ao número binário representado por s.
;; s é uma string de "a"s e "b"s onde "a" corresponde a 0 e "b" corresponde a 1.
(examples
  (check-equal? (ab->number "a") 0)
  (check-equal? (ab->number "b") 1)
  (check-equal? (ab->number "ba") 2)
  (check-equal? (ab->number "bb") 3)
  (check-equal? (ab->number "bab") 5))

(define (ab->number s)
  (string->number
   (string-replace (string-replace s "a" "0" ) "b" "1")
   2))

;; String -> Boolean
;;
;; Produz #t se palavra é duplicada, isto é, é formada pela ocorrência
;; de duas partes iguais separadas ou não por hífen. Devolve #f se
;; palavra não é duplicada

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
