#lang racket

(require examples)

; Análise
;
; a) Determinar se um clique aconteceu sobre uma janela.
; b) Determinar se o espaço de duas janelas se soprepõem

; Definição de tipos de dados

(struct janela (x y largura altura) #:transparent)
;; Representa o espaço que uma janela ocupa em um ambiente gráfico.
;;
;; x: Inteiro - coordenada x do canto superior esquerdo
;; y: Inteiro - coordenada y do canto superior esquerdo
;; largura: Natural - a quantidade de pixels à direita de (x, y)
;; altura: Natural - a quantidade de pixels abaixo de (x, y)


(struct clique (x y) #:transparent)
;; Representa a posição de um clique no ambiente gráfico.
;;
;; x: Natural - coordenada x, deve ser maior que 0 e menor que a largura do ambiente
;; y: Natural - coordenada y, deve ser maior que 0 e menor que a altura do ambiente


;; Janela Clique -> Booleano
;;
;; Devolve #t se o clique c está dentro do espaço da janela j, #f caso contrário.

(define jj (janela 100 100 300 200))
(examples
  ;  x = 100, y = 100, largura = 300, altura = 200
  ;
  ;        p5
  ;      +-----------+
  ;  p4  | p1        | p2
  ;      |           |
  ;      +-----------+
  ;        p3
  ; p1 - dentro da janela
  (check-equal? (dentro-janela jj (clique 150 150)) #t)
  ; p2 - dentro do espaço da altura e depois do espaço da largura
  (check-equal? (dentro-janela jj (clique 600 150)) #f)
  ; p3 - depois do espaço da altura e dentro do espaço da largura
  (check-equal? (dentro-janela jj (clique 150 300)) #f)
  ; p4 - dentro do espaço da altura e antes do espaço da largura
  (check-equal? (dentro-janela jj (clique 150 50)) #f)
  ; p5 - antes do espaço da altura e dentro do espaço da largura
  (check-equal? (dentro-janela jj (clique 150 50)) #f)
  ; canto superior esquerdo
  (check-equal? (dentro-janela jj (clique 100 100)) #t)
  ; canto superior direito
  (check-equal? (dentro-janela jj (clique 399 100)) #t)
  (check-equal? (dentro-janela jj (clique 400 100)) #f)
  ; canto inferior direito
  (check-equal? (dentro-janela jj (clique 399 299)) #t)
  (check-equal? (dentro-janela jj (clique 400 299)) #f)
  (check-equal? (dentro-janela jj (clique 399 300)) #f)
  (check-equal? (dentro-janela jj (clique 400 300)) #f)
  ; canto inferior esquerdo
  (check-equal? (dentro-janela jj (clique 100 299)) #t)
  (check-equal? (dentro-janela jj (clique 100 300)) #f))

(define (dentro-janela j c)
  (and (<= (janela-x j) (clique-x c))
       (< (clique-x c) (+ (janela-x j) (janela-largura j)))
       (<= (janela-y j) (clique-y c))
       (< (clique-y c) (+ (janela-y j) (janela-altura j)))))


;; Janela Janela -> Booleano
;;
;; Produz #t se o espaço das janelas a e b se soprepõem, #f caso contrário.
(examples
  ; fixa (eixo y): a janela a vem antes da janela b
  ; variável: posição da borda direita de a
  (check-equal? (janelas-soprepoem (janela  10 20 100 200) (janela 300 400 50 100)) #f)
  (check-equal? (janelas-soprepoem (janela 210 20 100 200) (janela 300 400 50 100)) #f)
  (check-equal? (janelas-soprepoem (janela 310 20 100 200) (janela 300 400 50 100)) #f)
  (check-equal? (janelas-soprepoem (janela 410 20 100 200) (janela 300 400 50 100)) #f)
  ; fixa: (eixo y) interseção da parte de baixo de a com a parte de cima de b
  ; variável: posição da borda direita de a
  (check-equal? (janelas-soprepoem (janela  10 250 100 200) (janela 300 400 50 100)) #f)
  (check-equal? (janelas-soprepoem (janela 210 250 100 200) (janela 300 400 50 100)) #t)
  (check-equal? (janelas-soprepoem (janela 310 250 100 200) (janela 300 400 50 100)) #t)
  (check-equal? (janelas-soprepoem (janela 410 250 100 200) (janela 300 400 50 100)) #f)
  ; fixa: (eixo y) interseção da parte de cima de a com a parte de baixo de b
  ; variável: posição da borda direita de a
  (check-equal? (janelas-soprepoem (janela  10 450 100 200) (janela 300 400 50 100)) #f)
  (check-equal? (janelas-soprepoem (janela 210 450 100 200) (janela 300 400 50 100)) #t)
  (check-equal? (janelas-soprepoem (janela 310 450 100 200) (janela 300 400 50 100)) #t)
  (check-equal? (janelas-soprepoem (janela 410 450 100 200) (janela 300 400 50 100)) #f)
  ; fixa: (eixo y) a janela a vem depois da janela b
  ; variável: posição da borda direita de a
  (check-equal? (janelas-soprepoem (janela  10 550 100 200) (janela 300 400 50 100)) #f)
  (check-equal? (janelas-soprepoem (janela 210 550 100 200) (janela 300 400 50 100)) #f)
  (check-equal? (janelas-soprepoem (janela 310 550 100 200) (janela 300 400 50 100)) #f)
  (check-equal? (janelas-soprepoem (janela 410 550 100 200) (janela 300 400 50 100)) #f))

(define (janelas-soprepoem a b)
  (and (< (janela-x a) (+ (janela-x b) (janela-largura b)))
       (< (janela-x b) (+ (janela-x a) (janela-largura a)))
       (< (janela-y a) (+ (janela-y b) (janela-altura b)))
       (< (janela-y b) (+ (janela-y a) (janela-altura a)))))
