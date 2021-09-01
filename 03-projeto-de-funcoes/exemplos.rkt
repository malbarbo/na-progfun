#lang racket

(require examples)

;;;;;;;
;; Tipos de dados

;; Preco é um número positivo com três casas decimais.

;; Combustivel é um dos valores
;; - "Alcool"
;; - "Gasolina"

;; Salario é um número positivo com duas casas decimais.

;; Comprimento é um número positivo dado em metros.

;; Massa é um número positivo dado em quilogramas.

;; Alinhamento é um dos valores
;; - "direita"
;; - "esquerda"
;; - "centro"


;;;;;;;
;; Constantes

(define DENSIDADE-FERRO 7874) ; Em kg/m^2


;;;;;;;
;; Funções

;; Preco Preco -> Combustivel
;;
;; Encontra o combustivel que deve ser utilizado no abastecimentos.
;; Produz "Alcool" se preco-alcool menor ou igual a 70% do preco-gasolina,
;; produz "Gasolina" caso contrário.
(examples
 (check-equal? (seleciona-combustivel 3.000 4.000) "Gasolina")
 (check-equal? (seleciona-combustivel 2.900 4.200) "Alcool")
 (check-equal? (seleciona-combustivel 3.500 5.000) "Alcool"))

(define (seleciona-combustivel preco-alcool preco-gasolina)
  (if (<= preco-alcool (* 0.7 preco-gasolina))
      "Alcool"
      "Gasolina"))


;; Salario -> Salario

;; Calcula o novo salário a partir de um percetual de aumento determinado a partir de salario-atual
;; da seguinte forma:
;; - salario-atual <= 1200, percentual de aumento de 10%
;; - 1200 < salario-atual <= 3000, percentual de aumento de 7%
;; - 3000 < salario-atual <= 8000, percentual de aumento de 3%
;; - 8000 < salario-atual, sem aumento

(examples
 (check-equal? (novo-salario 1000.00) 1100.00)
 (check-equal? (novo-salario 1200.00) 1320.00)
 (check-equal? (novo-salario 2000.00) 2140.00)
 (check-equal? (novo-salario 3000.00) 3210.00)
 (check-equal? (novo-salario 5000.00) 5150.00)
 (check-equal? (novo-salario 8000.00) 8240.00)
 (check-equal? (novo-salario 8000.01) 8000.01))

(define (novo-salario salario-atual)
  (cond
    [(<= salario-atual 1200) (* salario-atual 1.10)] ; 10% de aumento
    [(<= salario-atual 3000) (* salario-atual 1.07)] ; 7% de aumento
    [(<= salario-atual 8000) (* salario-atual 1.03)] ; 3% de aumento
    [else salario-atual]))                           ; sem aumento


;; Comprimento Comprimento Comprimento -> Massa

;; Calcula a massa de um tubo de ferro a partir da suas dimensões
(examples
 (check-= (massa-tubo-ferro 0.05 0.03 0.1) 0.2472436 0.00000001))

(define (massa-tubo-ferro diametro-externo diametro-interno altura)
  (define area-da-base (* 3.14 (sqr (/ (- diametro-externo diametro-interno) 2))))
  (define volume (* area-da-base altura))
  (* volume DENSIDADE-FERRO))


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
 (check-equal? (ajusta-string "casa" 4 "direita") "casa")
 (check-equal? (ajusta-string "casa" 4 "esquerda") "casa")
 (check-equal? (ajusta-string "casa" 4 "centro") "casa")
 (check-equal? (ajusta-string "casa verde" 7 "direita") "casa...")
 (check-equal? (ajusta-string "casa verde" 7 "esquarda") "casa...")
 (check-equal? (ajusta-string "casa verde" 7 "centro") "casa...")
 (check-equal? (ajusta-string "casa verde" 9 "direita") "casa v...")
 (check-equal? (ajusta-string "casa" 9 "direita") "     casa")
 (check-equal? (ajusta-string "casa" 9 "esquerda") "casa     ")
 (check-equal? (ajusta-string "casa" 9 "centro") "  casa   ")
 (check-equal? (ajusta-string "casa" 10 "centro") "   casa   "))

(define (ajusta-string s num-chars alinhamento)
  (cond
    [(= (string-length s) num-chars) s]
    [(> (string-length s) num-chars) (string-append (substring s 0 (- num-chars 3)) "...")]
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
