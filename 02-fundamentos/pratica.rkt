#lang racket

;; O código desse arquivo utiliza o processo de projeto de funções que
;; veremos nas próximas aulas. Os exercícios pediam apenas a implementação das
;; funções e a execução manual dos exemplos.
;;
;; Para executar os exemplos é necessário instalar a biblioteca examples.
;; Para isso, selecione o menu File -> Install Package e cole a url
;; https://github.com/malbarbo/racket-test-examples

(require examples)

;; Número Número -> Número
;;
;; Calcula a área de um retângulo com dimensões largura x altura.
(examples
  (check-equal? (area-retangulo 3 5) 15)
  (check-equal? (area-retangulo 2.0 2.5) 5.0))

(define (area-retangulo largura altura)
  (* largura altura))


;; Inteiro -> Inteiro
;;
;; Calcula o produto de n, (+ n 1) e (- n 1).
(examples
  (check-equal? (produto-anterior-posterior 3) 24)
  (check-equal? (produto-anterior-posterior 1) 0)
  (check-equal? (produto-anterior-posterior -2) -6))

(define (produto-anterior-posterior n)
  ; ou (* n (add1 n) (sub1 n))
  (* n (+ n 1) (- n 1)))


;; Número Número -> Número
;;
;; Calcula um novo valor aumentando a porcentagem ao valor dado.
(examples
  (check-equal? (aumenta 100.0 3.0) 103.0)
  (check-equal? (aumenta 20.0 50.0) 30.0)
  (check-equal? (aumenta 10.0 80.0) 18.0))

(define (aumenta valor porcentagem)
  (* valor (+ 1 (/ porcentagem 100))))


;; Natural -> Natural
;;
;; Produz um número substituindo a unidade e dezena de n por 0.
(examples
  (check-equal? (zera-dezena-unidade 19) 0)
  (check-equal? (zera-dezena-unidade 341) 300)
  (check-equal? (zera-dezena-unidade 5251) 5200))

(define (zera-dezena-unidade n)
  ; ou (- n (remainder n 100))
  (* 100 (quotient n 100)))


;; Natural - Booleano
;;
;; Produz #t se n é par, isto é, um múltiplo de 2, #f caso contrário.
(examples
  (check-equal? (par? 3) #f)
  (check-equal? (par? 6) #t))

(define (par? n)
  ; ou (zero? (remainder n 2))
  (= (remainder n 2) 0))


;; String Natural -> String
;;
;; Produz uma nova string substituindo cada um dos primeiros n caracteres de
;; frase por "x".
;;
;; Pergunta: o que acontece se n for maior do que a quantidade de caracteres
;; de frase? Altere a função para que ela tenha um comportamento mais
;; adequado nesse caso e envie a sua solução para professor explicando o
;; comportamento esperado. O primeiro aluno a enviar uma soluç̃ão adequada
;; ganha 0,1 na nota da prova.
(examples
  (check-equal? (censura "droga de lanche!" 5) "xxxxx de lanche!")
  (check-equal? (censura "ferrou geral!" 6) "xxxxxx geral!"))

(define (censura frase n)
  (string-append (make-string n #\x)
                 (substring frase n)))


;; Número Número -> Número
;;
;; Devolve o valor máximo entre a e b.
(examples
  (check-equal? (maximo 3 5) 5)
  (check-equal? (maximo 8 4) 8)
  (check-equal? (maximo 6 6) 6))

(define (maximo a b)
  (if (>= a b) a b)) ; veja a função pré-definida max


;; Número Número Número -> Número
;;
;; Devolve o valor máximo entre a, b e c.
(examples
  (check-equal? (maximo3 8 5 2) 8)
  (check-equal? (maximo3 4 6 1) 6)
  (check-equal? (maximo3 6 6 7) 7))

(define (maximo3 a b c)
  ; Você consegue escrever uma versão que usa o operador >= apenas duas vezes?
  ; Se sim, seja o primeiro a enviar para o professor e ganhe 0,1 na nota da prova.
  ; ou (maximo (maximo a b) c)
  (if (>= a b)
      (if (>= a c) a c)
      (if (>= b c) b c)))
