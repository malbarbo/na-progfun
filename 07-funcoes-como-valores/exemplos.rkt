#lang racket

(require examples)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Vamos criar uma função que abstrai o comportamento das funções contem-5? e
;; contem-3?.

;; Lista(Número) -> Boolean
;; Devolve #t se 5 está em lst, #f caso contrário.
(examples
 (check-equal? (contem-5? empty) #f)
 (check-equal? (contem-5? (list 3)) #f)
 (check-equal? (contem-5? (list 5)) #t)
 (check-equal? (contem-5? (list 3 -4 5 9 10)) #t)
 (check-equal? (contem-5? (list 2 -5 -2)) #f))

;; Implementação inicial da função contem-5?
#;
(define (contem-5? lst)
  (cond
    [(empty? lst) #f]
    [(= 5 (first lst)) #t]
    [else (contem-5? (rest lst))]))

;; Lista(Número) -> Boolean
;; Devolve #t se 3 está em lst, #f caso contrário.
(examples
 (check-equal? (contem-3? empty) #f)
 (check-equal? (contem-3? (list 3)) #t)
 (check-equal? (contem-3? (list 5)) #f)
 (check-equal? (contem-3? (list 3 -4 5 9 10)) #t)
 (check-equal? (contem-3? (list 2 -5 -2)) #f))

;; Implementação inicial da função contem-3?
#;
(define (contem-3? lst)
  (cond
    [(empty? lst) #f]
    [(= 3 (first lst)) #t]
    [else (contem-3? (rest lst))]))

;; Olhando para o corpo das funções contem-5? e contem-3? observa-se que a
;; única diferença é a ocorrência do valor 5 e 3.
;;
;; Vamos abstrair estas duas funções e criar a função contem? que além da
;; lista, recebe como parâmetro n, que será usado no lugar do 5 (ou 3).
;;
;; Em seguida vamos reescrever as funções contem-5? e contem-3? em termos da
;; função contem?.

;; Número Lista(Número) -> Boolean
;; Devolve #t se n está em lst, #f caso contrário.
(examples
 (check-equal? (contem? 3 empty) #f)
 (check-equal? (contem? 3 (list 3)) #t)
 (check-equal? (contem? 8 (list 5)) #f)
 (check-equal? (contem? 5 (list 3 -4 5 9 10)) #t)
 (check-equal? (contem? 5 (list 2 -5 -2)) #f))

(define (contem? n lst)
  (cond
    [(empty? lst) #f]
    [(= n (first lst)) #t]
    [else (contem? n (rest lst))]))

;; Função contem-5? escrita em termos da função contem?
(define (contem-5? lst)
  (contem? 5 lst))

;; Função contem-3? escrita em termos da função contem?
(define (contem-3? lst)
  (contem? 3 lst))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Vamos criar uma função que abstrai o comportamento das funções
;; lista-quadrado e lista-soma1.

;; Lista(Número) -> Lista(Número)
;; Devolve uma lista com o quadrado de cada número de lst.
(examples
 (check-equal? (lista-quadrado empty)
               empty)
 (check-equal? (lista-quadrado (list 4))
               (list 16))
 (check-equal? (lista-quadrado (list 7 9 1))
               (list 49 81 1)))

;; Implementação inicial da função lista-quadrado
#;
(define (lista-quadrado lst)
  (cond
    [(empty? lst) empty]
    [else (cons (sqr (first lst))
                (lista-quadrado (rest lst)))]))

;; Lista(Número) -> Lista(Número)
;; Devolve uma lista com cada número de lst somado de 1.
(examples
 (check-equal? (lista-soma1 empty)
               empty)
 (check-equal? (lista-soma1 (list 4))
               (list 5))
 (check-equal? (lista-soma1 (list 7 9 1))
               (list 8 10 2)))

;; Implementação inicial da função lista-soma1
#;
(define (lista-soma1 lst)
  (cond
    [(empty? lst) empty]
    [else (cons (add1 (first lst))
                (lista-soma1 (rest lst)))]))

;; Olhando para o corpo das funções lista-soma1 e lista-sqr observa-se que a
;; única diferença é a ocorrência da função sqr e add1.
;;
;; Da mesma forma que fizemos anteriormente vamos abstrair estas duas funções e
;; criar a função mapeia (a função mapeia os elementos de uma lista usando um
;; função) que além da lista, recebe como parâmetro f, que será usado no lugar
;; de sqr (ou add1).
;;
;; Em seguida vamos definir as funções lista-soma1 e lista-sqr em termos da
;; função mapeia.

;; (X -> Y) Lista(X) -> Lista(Y)
;; Devolve uma lista aplicando f a cada elemento de lst, isto é
;; (mapeia f (lista x1 x2 ... xn)) devolve
;; (lista (f x1) (f x2) ... (f xn))
;; Veja a função pré-definida map.
(examples
 (check-equal? (mapeia add1 empty)
               empty)
 (check-equal? (mapeia positive? (list 4 -1 2))
               (list #t #f #t)))

#;
(define (mapeia f lst)
  (cond
    [(empty? lst) empty]
    [else (cons (f (first lst))
                (mapeia f (rest lst)))]))

;; Função lista-quadrado escrita em termos de mapeia.
(define (lista-quadrado lst)
  (mapeia sqr lst))

;; Função lista-soma1 escrita em termos de mapeia.
(define (lista-soma1 lst)
  (mapeia add1 lst))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Vamos criar uma função que abstrai o comportamento das funções
;; lista-positivos e lista-pares.

;; Lista(Número) -> Lista(Número)
;; Devolve uma lista com os valores positivos de lst.
(examples
 (check-equal? (lista-positivos empty)
               empty)
 (check-equal? (lista-positivos (list -3 2 -7))
               (list 2))
 (check-equal? (lista-positivos (list 7 -2 9 20 -11))
               (list 7 9 20)))

;; Implementação inicial da função lista-positivos
#;
(define (lista-positivos lst)
  (cond
    [(empty? lst) empty]
    [(positive? (first lst))
     (cons (first lst) (lista-positivos (rest lst)))]
    [else
     (lista-positivos (rest lst))]))

;; Lista(Número) -> Lista(Número)
;; Devolve uma lista com os valores positvos de lst.
(examples
 (check-equal? (lista-pares empty)
               empty)
 (check-equal? (lista-pares (list 3 2 7))
               (list 2))
 (check-equal? (lista-pares (list 7 2 9 20 11))
               (list 2 20)))

;; Implementação inicial da função lista-pares
#;
(define (lista-pares lst)
  (cond
    [(empty? lst) empty]
    [(even? (first lst))
     (cons (first lst) (lista-pares (rest lst)))]
    [else (lista-pares (rest lst))]))

;; Olhando para o corpo das funções lista-positivos e lista-pares observa-se
;; que a única diferença é a ocorrência da função positive? e even?.
;;
;; Da mesma forma que fizemos anteriormente vamos abstrair estas duas funções e
;; criar a função filtra (a função filtra uma lista usando um predicado) que
;; além da lista, recebe como parâmetro pred, que será usado no lugar de
;; positive? (ou even?).
;;
;; Em seguida vamos definir as funções lista-positivos e lista-pares em termos
;; da função filtra.

;; (X -> Boolean) Lista(X) -> Lista(X)
;; Devolve uma lista com todos os elementos x de lst tal que (pred x) é #t.
;; Veja a função pré-definida filter.
(examples
 (check-equal? (filtra even? empty)
               empty)
 (check-equal? (filtra positive? (list 3 -2 7))
               (list 3 7)))

#;
(define (filtra pred? lst)
  (cond
    [(empty? lst) empty]
    [(pred? (first lst))
     (cons (first lst) (filtra pred? (rest lst)))]
    [else (filtra pred? (rest lst))]))

;; Função lista-positivos escrita em termos de filtra.
(define (lista-positivos lst)
  (filtra positive? lst))

;; Função lista-pares escrita em termos de filtra.
(define (lista-pares lst)
  (filtra even? lst))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Vamos criar uma função que abstrai o comportamento das funções soma e
;; produto.

;; Lista(Número) -> Número
;; Calula a soma dos números de uma lista.
(examples
 (check-equal? (soma empty) 0)
 (check-equal? (soma (list 3)) 3)
 (check-equal? (soma (list 3 5)) 8)
 (check-equal? (soma (list 3 5 -2)) 6))

;; Implementação inicial da função soma
#;
(define (soma lst)
  (cond
    [(empty? lst) 0]
    [else (+ (first lst)
             (soma (rest lst)))]))

;; Lista(Número) -> Número
;; Calcula o produto dos números de uma lista.
(examples
 (check-equal? (produto empty) 1)
 (check-equal? (produto (list 3)) 3)
 (check-equal? (produto (list 3 5)) 15)
 (check-equal? (produto (list 3 5 -2)) -30))

;; Implementação inicial da função produto
#;
(define (produto lst)
  (cond
    [(empty? lst) 1]
    [else (* (first lst)
             (produto (rest lst)))]))

;; Olhando para o corpo das funções soma e produto observa-se que as únicas
;; diferenças são a ocorrência do valor 0 e 1 e da função + e *.
;;
;; Da mesma forma que fizemos com as funções contem-5? e contem-3?  vamos
;; abstrair estas duas funções e criar a função reduz (a função reduz uma lista
;; a um valor) que além da lista, recebe como parâmetro f, que será usado no
;; lugar de + (ou *) e base que será usado no lugar de 0 (ou 1).
;;
;; Em seguida vamos reescrever as funções soma e produto em termos de reduz.

;; (X Y -> Y) Y Lista(X) -> Y
;; (reduz f base (list x1 x2 ... xn) devolve
;; (f x1 (f x2 ... (f xn base)))
;; Veja a função pré-definida foldr.
(examples
 (check-equal? (reduz + 0 empty) 0)
 (check-equal? (reduz * 1 (list 3 5 -2)) -30))

(define (reduz f base lst)
  (cond
    [(empty? lst) base]
    [else (f (first lst)
             (reduz f base (rest lst)))]))

;; Função soma escrita em termos de reduz.
(define (soma lst)
  (reduz + 0 lst))

;; Função produto escrita em termos de reduz.
(define (produto lst)
  (reduz * 1 lst))

;; A função reduz é tão abstrata que pode ser usada para definir muitas outras
;; funções. Vamos definir a função concatena em termos da função reduz.

;; Lista Lista -> Lista
;; Cria uma nova lista com os elementos de lst1 antes de lst2.
(examples
 (check-equal? (concatena empty empty)
               empty)
 (check-equal? (concatena (list 4 7) empty)
               (list 4 7))
 (check-equal? (concatena empty (list 5 9))
               (list 5 9))
 (check-equal? (concatena (list 5 9) (list 7 9 20))
               (list 5 9 7 9 20)))

;; Implementação inicial da função concatena
#;
(define (concatena lst1 lst2)
  (cond
    [(empty? lst1) lst2]
    [else (cons (first lst1)
                (concatena (rest lst1) lst2))]))

;; Analisando o corpo das funções reduz e concatena, percebemos que o parâmetro
;; op deve ser cons e que o parâmetro base deve ser lst2. Desta forma,
;; definimos concatena em termos de reduz.
(define (concatena lst1 lst2)
  (reduz cons lst2 lst1))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Defina a função mapeia em termos da função reduz.

(define (mapeia f lst)
  (define (cons-f e lst) (cons (f e) lst))
  (reduz cons-f empty lst))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Defina a função filtra em termos da função reduz.

(define (filtra pred? lst)
  (define (cons-if e lst)
    (if (pred? e) (cons e lst) lst))
  (reduz cons-if empty lst))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Defina uma função que recebe um parâmetro n e devolva uma função que soma o
;; seu parâmetro a n.

;; Número -> (Número -> Número)
;; Devolve uma função que recebe uma parâmetro x e faz a soma de n e x.
(examples
 (check-equal? ((somador 4) 3) 7)
 (check-equal? ((somador -2) 8) 6))

#;
(define (somador n)
  (define (soma x)
    (+ n x))
  soma)

;; Versão com função anônima.
(define (somador n)
  (λ (x)(+ n x)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Defina uma função que recebe como parâmetro um predicado (função que retorna
;; verdadeiro ou falso) e retorne uma função que retorna a negação do
;; predicado.

;; (X -> Boolean) -> (X -> Boolean)
;; Devolve uma função que é semelhante a pred, mas que devolve a negação do
;; resultado de pred.
(examples
 (check-equal? ((nega positive?) 3) #f)
 (check-equal? ((nega positive?) -3) #t)
 (check-equal? ((nega even?) 4) #f)
 (check-equal? ((nega even?) 3) #t))

;; Veja a função pré-definida negate.
(define (nega pred)
  (λ (x) (not (pred x))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Defina uma função que implemente o algoritmo de ordenação quicksort.

;; Lista(Número) -> Lista(Número)
;; Ordena uma lista de números usando o quicksort.
(examples
 (check-equal? (quicksort empty)
               empty)
 (check-equal? (quicksort (list 3))
               (list 3))
 (check-equal? (quicksort (list 10 3 -4 5 9))
               (list -4 3 5 9 10))
 (check-equal? (quicksort (list 3 10 3 0 5 0 9))
               (list 0 0 3 3 5 9 10)))

(define (quicksort lst)
  (if (empty? lst)
      empty
      (let ([pivo (first lst)]
            [resto (rest lst)])
        (append (quicksort (filter (curryr < pivo) resto))
                (list pivo)
                (quicksort (filter (curryr >= pivo) resto))))))
