#lang racket

;; O código desse arquivo utiliza o processo de projeto de funções que
;; veremos nas próximas aulas. Os exercícios pediam apenas a implementação das
;; funções e a execução manual dos exemplos.
;;
;; Para executar os testes é necessário instalar a biblioteca examples.
;; Para isso, selecione o menu File -> Install Package e cole a url
;; https://github.com/malbarbo/racket-test-examples

(require examples)

;; Natural -> Booleano
;;
;; Produz #t se n tem três digitos, #f caso contrário.
(examples
  (check-equal? (tres-digitos? 8) #f)
  (check-equal? (tres-digitos? 98) #f)
  (check-equal? (tres-digitos? 182) #t)
  (check-equal? (tres-digitos? 1234) #f))

(define (tres-digitos? n)
  (<= 100 n 999))


;; String -> Booleano
;;
;; Produz #t se s tem um número ímpar de caracteres e o caracter do meio é "-",
;; #f caso contrário.
(examples
  (check-equal? (traco-meio? "lero-lero") #t)
  (check-equal? (traco-meio? "quase-meio") #f)
  (check-equal? (traco-meio? "-") #t))

(define (traco-meio? s)
  (define tam (string-length s))
  (define meio (quotient tam 2))
  (and (= (remainder tam 2) 1) ; veja a função pré-definida odd?
       (equal? (substring s meio (add1 meio)) "-")))


;; String -> String
;;
;; Adiciona um ponto final (".") em frase se ela ainda não terminar com um.
(examples
  (check-equal? (adiciona-ponto "Vou contar") "Vou contar.")
  (check-equal? (adiciona-ponto "Corri") "Corri."))

(define (adiciona-ponto frase)
  (if (equal? (substring frase (- (string-length frase) 1))
              ".")
      frase
      (string-append frase ".")))


;; Número Número Número -> String
;;
;; Determinar se a sequência a, b, c está em ordem "crescente",
;; "decrescente" ou "sem ordem".
(examples
  (check-equal? (ordem 3 8 12) "crescente")
  (check-equal? (ordem 3 1 4) "sem ordem")
  (check-equal? (ordem 3 1 0) "decrescente"))

(define (ordem a b c)
  (cond
    [(<= a b c) "crescente"]
    [(<= c b a) "decrescente"]
    [else "sem ordem"]))
