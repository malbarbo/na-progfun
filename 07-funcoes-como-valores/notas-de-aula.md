---
# vim: set spell spelllang=pt_br sw=4:
# TODO: explicar como a anotação de tipo de função funciona
# TODO: explicitar que existe uma "algebra" de funções (assim como uma algebra de número, strings, etc)
# TODO: check-equal? está fora de examples
# TODO: remover explicação recursão generativa? Foi adicionado em autorreferencias
# TODO: remover seção de funções com número variado de parâmetros?
title: Funções como valores
---

Introdução
==========


## Introdução

<!-- TODO: melhorar o agrupamento e os nomes das seções !-->
<!-- TODO: dividir em mais de um módulo? !-->

As principais características que vimos até agora do paradigma funcional foram \pause

- Ausência de mudança de estado; \pause

- Tipos algébricos e autorreferências; \pause

- Recursão como forma de especificar iteração. \pause

Veremos a seguir outra característica essencial do paradigma funcional.


## Introdução


Funções como entidades de primeira classe (ou funções como valores) \pause

- Podem ser usadas, sem restrições, onde outros valores podem ser usados (passado como parâmetro, retornado, armazenado em listas, etc); \pause

- Podem ser construídas, sem restrições, onde outros valores também podem (localmente, em expressões, etc); \pause

- Podem ser "tipadas" de forma similar a outro valores, ou seja, existe um tipo associado com cada função e esse tipo podem ser usado para compor outro tipos.


## Introdução

Uma **função de alta ordem** é aquela que recebe como parâmetro uma função ou produz uma função com resultado.



Funções que recebem funções como parâmetro
==========================================


## Funções que recebem funções como parâmetro

Como identificar a necessidade de utilizar funções como parâmetro? \pause

Encontrando similaridades entre funções. \pause

Vamos ver diversas funções e tentar identificar similaridades.


## Exemplo: contem-3? e contem-5?

Vamos fazer um exemplo simples. Vamos criar uma função que abstrai o comportamento das funções `contem-3?` e `contem-5?`.


## Exemplo: contem-3? e contem-5?

<div class="columns">
<div class="column" width="50%">
\scriptsize

```scheme
;; Lista(Número) -> Boolean
;; Devolve #t se 3 está em lst,
;; #f caso contrário.
(check-equal? (contem-3? (list 4 3 1)) #t)
(define (contem-3? lst)
  (cond
    [(empty? lst) #f]
    [(= 3 (first lst)) #t]
    [else (contem-3? (rest lst))]))

;; Lista(Número) -> Boolean
;; Devolve #t se 5 está em lst,
;; #f caso contrário.
(check-equal? (contem-5? (list 4 3 1)) #f)
(define (contem-5? lst)
  (cond
    [(empty? lst) #f]
    [(= 5 (first lst)) #t]
    [else (contem-5? (rest lst))]))
```
</div>
<div class="column" width="50%">
\pause

\scriptsize

Vamos definir uma função que abstrai o comportamento de `contem-3?` e `contem-5?`. \pause

```scheme





(define (contem? n lst)
  (cond
    [(empty? lst) #f]
    [(= n (first lst)) #t]
    [else (contem? n (rest lst))]))
```
</div>
</div>


## Exemplo: contem-3? e contem-5?

<div class="columns">
<div class="column" width="50%">
\scriptsize

```scheme
;; Lista(Número) -> Boolean
;; Devolve #t se 3 está em lst,
;; #f caso contrário.
(check-equal? (contem-3? (list 4 3 1)) #t)
(define (contem-3? lst)
  (cond
    [(empty? lst) #f]
    [(= 3 (first lst)) #t]
    [else (contem-3? (rest lst))]))

;; Lista(Número) -> Boolean
;; Devolve #t se 5 está em lst,
;; #f caso contrário.
(check-equal? (contem-5? (list 4 3 1)) #f)
(define (contem-5? lst)
  (cond
    [(empty? lst) #f]
    [(= 5 (first lst)) #t]
    [else (contem-5? (rest lst))]))
```
</div>
<div class="column" width="50%">
\scriptsize

Vamos definir uma função que abstrai o comportamento de `contem-3?` e `contem-5?`.

```scheme



(check-equal? (contem? 3 (list 4 3 1)) #t)
(check-equal? (contem? 2 (list 4 3 1)) #f)
(define (contem? n lst)
  (cond
    [(empty? lst) #f]
    [(= n (first lst)) #t]
    [else (contem? n (rest lst))]))
```
</div>
</div>


## Exemplo: contem-3? e contem-5?

<div class="columns">
<div class="column" width="50%">
\scriptsize

```scheme
;; Lista(Número) -> Boolean
;; Devolve #t se 3 está em lst,
;; #f caso contrário.
(check-equal? (contem-3? (list 4 3 1)) #t)
(define (contem-3? lst)
  (cond
    [(empty? lst) #f]
    [(= 3 (first lst)) #t]
    [else (contem-3? (rest lst))]))

;; Lista(Número) -> Boolean
;; Devolve #t se 5 está em lst,
;; #f caso contrário.
(check-equal? (contem-5? (list 4 3 1)) #f)
(define (contem-5? lst)
  (cond
    [(empty? lst) #f]
    [(= 5 (first lst)) #t]
    [else (contem-5? (rest lst))]))
```
</div>
<div class="column" width="50%">
\scriptsize

Vamos definir uma função que abstrai o comportamento de `contem-3?` e `contem-5?`.

```scheme
;; Número Lista(Número) -> Boolean
;; Devolve #t se n está em lst,
;; #f caso contrário.
(check-equal? (contem? 3 (list 4 3 1)) #t)
(check-equal? (contem? 2 (list 4 3 1)) #f)
(define (contem? n lst)
  (cond
    [(empty? lst) #f]
    [(= n (first lst)) #t]
    [else (contem? n (rest lst))]))
```
</div>
</div>


## Exemplo: contem-3? e contem-5?

<div class="columns">
<div class="column" width="50%">
\scriptsize

```scheme
;; Lista(Número) -> Boolean
;; Devolve #t se 3 está em lst,
;; #f caso contrário.
(check-equal? (contem-3? (list 4 3 1)) #t)
(define (contem-3? lst)
  (contem? 3 lst))
 
 
 
 
;; Lista(Número) -> Boolean
;; Devolve #t se 5 está em lst,
;; #f caso contrário.
(check-equal? (contem-5? (list 4 3 1)) #f)
(define (contem-5? lst)
  (contem? 5 lst))
 
 
 
```
</div>
<div class="column" width="50%">
\scriptsize

Vamos definir uma função que abstrai o comportamento de `contem-3?` e `contem-5?`.

```scheme
;; Número Lista(Número) -> Boolean
;; Devolve #t se n está em lst,
;; #f caso contrário.
(check-equal? (contem? 3 (list 4 3 1)) #t)
(check-equal? (contem? 2 (list 4 3 1)) #f)
(define (contem? n lst)
  (cond
    [(empty? lst) #f]
    [(= n (first lst)) #t]
    [else (contem? n (rest lst))]))
```
</div>
</div>


## Receita para criar abstração a partir de exemplos

1. Identificar funções com corpo semelhante

    - Identificar o que muda

    - Criar parâmetros para o que muda

    - Copiar o corpo e substituir o que muda pelos parâmetros criados \pause

2. Escrever os exemplos

    - Reutilizar os exemplos das funções existentes \pause

3. Escrever o propósito \pause

4. Escrever a assinatura \pause

5. Reescrever o código da funções iniciais em termos da nova função


## Exemplo: `lista-quadrado` e `lista-soma1`

Vamos criar uma função que abstrai o comportamento das funções `lista-quadrado` e `lista-soma1`.


## Exemplo: `lista-quadrado` e `lista-soma1`

<div class="columns">
<div class="column" width="53%">
\scriptsize

```scheme
;; Lista(Número) -> Lista(Número)
;; Devolve uma lista com cada número de lst
;; elevado ao quadrado.
(check-equal? (lista-quadrado (list 4)) (list 16))
(define (lista-quadrado lst)
  (cond
    [(empty? lst) empty]
    [else (cons (sqr (first lst))
                (lista-quadrado (rest lst)))]))
;; Lista(Número) -> Lista(Número)
;; Devolve uma lista com cada número de lst
;; somado de 1.
(check-equal? (lista-soma1 (list 7 9 1))
              (list 8 10 2)))
(define (lista-soma1 lst)
  (cond
    [(empty? lst) empty]
    [else (cons (add1 (first lst))
                (lista-soma1 (rest lst)))]))
```
</div>
<div class="column" width="47%">
\scriptsize

\pause

```scheme









(define (mapeia f lst)
  (cond
    [(empty? lst) empty]
    [else (cons (f (first lst))
                (mapeia f (rest lst)))]))
```
</div>
</div>


## Exemplo: `lista-quadrado` e `lista-soma1`

<div class="columns">
<div class="column" width="53%">
\scriptsize

```scheme
;; Lista(Número) -> Lista(Número)
;; Devolve uma lista com cada número de lst
;; elevado ao quadrado.
(check-equal? (lista-quadrado (list 4)) (list 16))
(define (lista-quadrado lst)
  (cond
    [(empty? lst) empty]
    [else (cons (sqr (first lst))
                (lista-quadrado (rest lst)))]))
;; Lista(Número) -> Lista(Número)
;; Devolve uma lista com cada número de lst
;; somado de 1.
(check-equal? (lista-soma1 (list 7 9 1))
              (list 8 10 2)))
(define (lista-soma1 lst)
  (cond
    [(empty? lst) empty]
    [else (cons (add1 (first lst))
                (lista-soma1 (rest lst)))]))
```
</div>
<div class="column" width="47%">
\scriptsize

```scheme





(check-equal? (mapeia sqr (list 4))
              (list 16))
(check-equal? (mapeia add1 (list 7 9 1))
              (list 8 10 2)))
(define (mapeia f lst)
  (cond
    [(empty? lst) empty]
    [else (cons (f (first lst))
                (mapeia f (rest lst)))]))
```
</div>
</div>


## Exemplo: `lista-quadrado` e `lista-soma1`

<div class="columns">
<div class="column" width="53%">
\scriptsize

```scheme
;; Lista(Número) -> Lista(Número)
;; Devolve uma lista com cada número de lst
;; elevado ao quadrado.
(check-equal? (lista-quadrado (list 4)) (list 16))
(define (lista-quadrado lst)
  (cond
    [(empty? lst) empty]
    [else (cons (sqr (first lst))
                (lista-quadrado (rest lst)))]))
;; Lista(Número) -> Lista(Número)
;; Devolve uma lista com cada número de lst
;; somado de 1.
(check-equal? (lista-soma1 (list 7 9 1))
              (list 8 10 2)))
(define (lista-soma1 lst)
  (cond
    [(empty? lst) empty]
    [else (cons (add1 (first lst))
                (lista-soma1 (rest lst)))]))
```
</div>
<div class="column" width="47%">
\scriptsize

```scheme
;; (Num -> Num) Lista(Num) -> Lista(Num)
;; Devolve uma lista aplicando f a cada
;; elemento de lst, isto é
;; (mapeia f (lista x1 x2 ... xn)) devolve
;; (lista (f x1) (f x2) ... (f xn))
(check-equal? (mapeia sqr (list 4))
              (list 16))
(check-equal? (mapeia add1 (list 7 9 1))
              (list 8 10 2)))
(define (mapeia f lst)
  (cond
    [(empty? lst) empty]
    [else (cons (f (first lst))
                (mapeia f (rest lst)))]))
```
</div>
</div>


## Exemplo: `lista-quadrado` e `lista-soma1`

<div class="columns">
<div class="column" width="53%">
\scriptsize

```scheme
;; Lista(Número) -> Lista(Número)
;; Devolve uma lista cada número de lst
;; elevado ao quadrado.
(check-equal? (lista-quadrado (list 4)) (list 16))
(define (lista-quadrado lst)
    (mapeia sqr lst))



;; Lista(Número) -> Lista(Número)
;; Devolve uma lista com cada número de lst
;; somado de 1.
(check-equal? (lista-soma1 (list 7 9 1))
              (list 8 10 2)))
(define (lista-soma1 lst)
    (mapeia add1 lst))



```
</div>
<div class="column" width="47%">
\scriptsize

```scheme
;; (Num -> Num) Lista(Num) -> Lista(Num)
;; Devolve uma lista aplicando f a cada
;; elemento de lst, isto é
;; (mapeia f (lista x1 x2 ... xn)) devolve
;; (lista (f x1) (f x2) ... (f xn))
(check-equal? (mapeia sqr (list 4))
              (list 16))
(check-equal? (mapeia add1 (list 7 9 1))
              (list 8 10 2)))
(define (mapeia f lst)
  (cond
    [(empty? lst) empty]
    [else (cons (f (first lst))
                (mapeia f (rest lst)))]))
```
</div>
</div>



map
===


## `map`

Como resultado do exemplo anterior obtivemos a função `mapeia`, que é pré-definida em Racket com o nome `map`.

\pause

```scheme
;; (X -> Y) Lista(X) -> Lista(Y)
;; Devolve uma lista aplicando f a cada elemento de lst,
;; isto é
;; (map f (lista x1 x2 ... xn)) produz
;; (list (f x1) (f x2) ... (f xn))
(define (map f lst)
  (cond
    [(empty? lst) empty]
    [else (cons (f (first lst))
                (map f (rest lst)))]))
```


## `map` - exemplos

```scheme
> (map add1 (list 4 6 10))
'(5 7 11)
> (map list (list 7 2 18))
'((7) (2) (18))
> (map length (list (list 7 2) (list 18) empty))
'(2 1 0)

```


## Exemplo: `lista-positivos` e `lista-pares`

Vamos criar uma função que abstrai o comportamento das funções `lista-positivos` e `lista-pares`.


## Exemplo: `lista-positivos` e `lista-pares`

<div class="columns">
<div class="column" width="55%">
\scriptsize

```scheme
;; Lista(Número) -> Lista(Número)
;; Devolve uma lista com os valores positivos de lst.
(define (lista-positivos lst)
  (cond
    [(empty? lst) empty]
    [(positive? (first lst))
     (cons (first lst)
           (lista-positivos (rest lst)))]
    [else (lista-positivos (rest lst))]))
;; Lista(Número) -> Lista(Número)
;; Devolve uma lista com os valores pares de lst.
(define (lista-pares lst)
  (cond
    [(empty? lst) empty]
    [(even? (first lst))
     (cons (first lst)
           (lista-pares (rest lst)))]
    [else (lista-pares (rest lst))]))
```
</div>
<div class="column" width="45%">
\scriptsize

\pause

```scheme







(define (filtra pred? lst)
  (cond
    [(empty? lst) empty]
    [(pred? (first lst))
     (cons (first lst)
           (filtra pred? (rest lst)))]
    [else (filtra pred? (rest lst))]))
```
</div>
</div>


## Exemplo: `lista-positivos` e `lista-pares`

<div class="columns">
<div class="column" width="55%">
\scriptsize

```scheme
;; Lista(Número) -> Lista(Número)
;; Devolve uma lista com os valores positivos de lst.
(define (lista-positivos lst)
  (cond
    [(empty? lst) empty]
    [(positive? (first lst))
     (cons (first lst)
           (lista-positivos (rest lst)))]
    [else (lista-positivos (rest lst))]))
;; Lista(Número) -> Lista(Número)
;; Devolve uma lista com os valores pares de lst.
(define (lista-pares lst)
  (cond
    [(empty? lst) empty]
    [(even? (first lst))
     (cons (first lst)
           (lista-pares (rest lst)))]
    [else (lista-pares (rest lst))]))
```
</div>
<div class="column" width="45%">
\scriptsize

```scheme



(check-equal? (filtra even? (list 4 2 7)
              (list 4 2)
(check-equal? (filtra positive? (list 3 -2))
              (list 3))
(define (filtra pred? lst)
  (cond
    [(empty? lst) empty]
    [(pred? (first lst))
     (cons (first lst)
           (filtra pred? (rest lst)))]
    [else (filtra pred? (rest lst))]))
```
</div>
</div>


## Exemplo: `lista-positivos` e `lista-pares`

<div class="columns">
<div class="column" width="55%">
\scriptsize

```scheme
;; Lista(Número) -> Lista(Número)
;; Devolve uma lista com os valores positivos de lst.
(define (lista-positivos lst)
  (cond
    [(empty? lst) empty]
    [(positive? (first lst))
     (cons (first lst)
           (lista-positivos (rest lst)))]
    [else (lista-positivos (rest lst))]))
;; Lista(Número) -> Lista(Número)
;; Devolve uma lista com os valores pares de lst.
(define (lista-pares lst)
  (cond
    [(empty? lst) empty]
    [(even? (first lst))
     (cons (first lst)
           (lista-pares (rest lst)))]
    [else (lista-pares (rest lst))]))
```
</div>
<div class="column" width="45%">
\scriptsize

```scheme
;; (Num -> Boolean) Lista(Num) -> Lista(Num)
;; Devolve uma lista com todos os elementos
;; x de lst tal que (pred? x) é #t.
(check-equal? (filtra even? (list 4 2 7)
              (list 4 2)
(check-equal? (filtra positive? (list 3 -2))
              (list 3))
(define (filtra pred? lst)
  (cond
    [(empty? lst) empty]
    [(pred? (first lst))
     (cons (first lst)
           (filtra pred? (rest lst)))]
    [else (filtra pred? (rest lst))]))
```
</div>
</div>


## Exemplo: `lista-positivos` e `lista-pares`

<div class="columns">
<div class="column" width="55%">
\scriptsize

```scheme
;; Lista(Número) -> Lista(Número)
;; Devolve uma lista com os valores positivos de lst.
(define (lista-positivos lst)
  (filtra positive? lst))





;; Lista(Número) -> Lista(Número)
;; Devolve uma lista com os valores
;; pares de lst.
(define (lista-pares lst)
  (filtra even? lst))





```
</div>
<div class="column" width="45%">
\scriptsize

```scheme
;; (Num -> Boolean) Lista(Num) -> Lista(Num)
;; Devolve uma lista com todos os elementos
;; x de lst tal que (pred? x) é #t.
(check-equal? (filtra even? (list 4 2 7)
              (list 4 2)
(check-equal? (filtra positive? (list 3 -2))
              (list 3))
(define (filtra pred? lst)
  (cond
    [(empty? lst) empty]
    [(pred? (first lst))
     (cons (first lst)
           (filtra pred? (rest lst)))]
    [else (filtra pred? (rest lst))]))
```
</div>
</div>



`filter`
======

## `filter`

Como resultado do exemplo anterior obtivemos a função `filtra`, que é pré-definida em Racket com o nome `filter`.

\pause

```scheme
;; (X -> Boolean) Lista(X) -> Lista(X)
;; Devolve uma lista com todos os elementos de lst
;; tal que pred? é #t.
(define (filter pred? lst)
  (cond
    [(empty? lst) empty]
    [(pred? (first lst))
     (cons (first lst)
           (filter pred? (rest lst)))]
    [else
     (filtra pred? (rest lst))]))
```


## `filter` - exemplos

```scheme
> (filter negative? (list 4 6 10))
'()
> (filter even? (list 7 2 18))
'(2 18)
```


## Exemplo: soma e produto

Vamos criar uma função que abstrai o comportamento das funções `soma` e `produto`.


## Exemplo: `soma` e `produto`

<div class="columns">
<div class="column" width="50%">
\scriptsize

```scheme
;; Lista(Número) -> Número
;; Devolve a soma dos números de lst.
(check-equal? (soma (list 4 3 1)) 8)
(define (soma lst)
  (cond
    [(empty? lst) 0]
    [else (+ (first lst)
             (soma (rest lst)))]))

;; Lista(Número) -> Número
;; Devolve o produto dos números de lst.
(check-equal? (prod (list 4 3 1)) 12)
(define (prod lst)
  (cond
    [(empty? lst) 1]
    [else (* (first lst)
             (prod (rest lst)))]))
```
</div>
<div class="column" width="50%">
\scriptsize

\pause

```scheme










(define (reduz f base lst)
  (cond
    [(empty? lst) base]
    [else (f (first lst)
             (reduz f base (rest lst)))]))
```
</div>
</div>


## Exemplo: `soma` e `produto`

<div class="columns">
<div class="column" width="50%">
\scriptsize

```scheme
;; Lista(Número) -> Número
;; Devolve a soma dos números de lst.
(check-equal? (soma (list 4 3 1)) 8)
(define (soma lst)
  (cond
    [(empty? lst) 0]
    [else (+ (first lst)
             (soma (rest lst)))]))

;; Lista(Número) -> Número
;; Devolve o produto dos números de lst.
(check-equal? (prod (list 4 3 1)) 12)
(define (prod lst)
  (cond
    [(empty? lst) 1]
    [else (* (first lst)
             (prod (rest lst)))]))
```
</div>
<div class="column" width="50%">
\scriptsize

```scheme






(check-equal? (reduz + 0 empty)
               0)
(check-equal? (reduz * 1 (list 3 5 -2))
               -30))
(define (reduz f base lst)
  (cond
    [(empty? lst) base]
    [else (f (first lst)
             (reduz f base (rest lst)))]))
```
</div>
</div>


## Exemplo: `soma` e `produto`

<div class="columns">
<div class="column" width="50%">
\scriptsize

```scheme
;; Lista(Número) -> Número
;; Devolve a soma dos números de lst.
(check-equal? (soma (list 4 3 1)) 8)
(define (soma lst)
  (cond
    [(empty? lst) 0]
    [else (+ (first lst)
             (soma (rest lst)))]))

;; Lista(Número) -> Número
;; Devolve o produto dos números de lst.
(check-equal? (prod (list 4 3 1)) 12)
(define (prod lst)
  (cond
    [(empty? lst) 1]
    [else (* (first lst)
             (prod (rest lst)))]))
```
</div>
<div class="column" width="50%">
\scriptsize

```scheme
;; (Num Num -> Num) Num Lista(Num) -> Num
;; Reduz os valores de lst a um único
;; valor usando a função f.
;; Uma chamada
;; (reduz f base (list x1 x2 ... xn)
;; devolve (f x1 (f x2 ... (f xn base))).
(check-equal? (reduz + 0 empty)
               0)
(check-equal? (reduz * 1 (list 3 5 -2))
               -30))
(define (reduz f base lst)
  (cond
    [(empty? lst) base]
    [else (f (first lst)
             (reduz f base (rest lst)))]))
```
</div>
</div>


## Exemplo: `soma` e `produto`

<div class="columns">
<div class="column" width="50%">
\scriptsize

```scheme
;; Lista(Número) -> Número
;; Devolve a soma dos números de lst.
(check-equal? (soma (list 4 3 1)) 8)
(define (soma lst)
  (reduz + 0 lst))




;; Lista(Número) -> Número
;; Devolve o produto dos números de lst.
(check-equal? (prod (list 4 3 1)) 12)
(define (prod lst)
  (reduz * 1 lst))



```
</div>
<div class="column" width="50%">
\scriptsize

```scheme
;; (Num Num -> Num) Num Lista(Num) -> Num
;; Reduz os valores de lst a um único
;; valor usando a função f.
;; Uma chamada
;; (reduz f base (list x1 x2 ... xn)
;; devolve (f x1 (f x2 ... (f xn base))).
(check-equal? (reduz + 0 empty)
               0)
(check-equal? (reduz * 1 (list 3 5 -2))
               -30))
(define (reduz f base lst)
  (cond
    [(empty? lst) base]
    [else (f (first lst)
             (reduz f base (rest lst)))]))
```
</div>
</div>



`foldr`
=====

## `foldr`

Como resultado do exemplo anterior obtivemos a função `reduz`, que é pré-definida em Racket com o nome `foldr`.

\pause

```scheme
;; (X Y -> Y) Y Lista(X) -> Y
;; A chamada
;; (foldr f base (list x1 x2 ... xn) produz
;; (f x1 (f x2 ... (f xn base)))
(define (foldr f base lst)
  (cond
    [(empty? lst) base]
    [else (f (first lst)
             (foldr f base (rest lst)))]))

```


## `foldr` - exemplos


```scheme
> (foldr + 0 (list 4 6 10))
20
> (foldr cons empty (list 7 2 18))
'(7 2 18)
> (foldr max 7 (list 7 2 18 -20))
18
```



## Funções `map`, `filter` e `foldr`

Quando utilizar as funções `map`, `filter` e `foldr`? \pause

- Quando a lista sempre é processa por inteiro. \pause

- `map`: quando queremos aplicar uma função a cada elemento de uma lista de forma independente. \pause

- `filter`: quando queremos selecionar alguns elementos de uma lista. \pause

- `foldr`: quando queremos calcular um resultado de forma incremental analisando cada elemento de uma lista. \pause

Na dúvida, faça o projeto da função recursiva e depois verifique se ela é um caso específico de `map`, `filter` ou `foldr`.


## Ordenação

Projete uma função que receba como entrada uma lista de números e devolva uma lista com os mesmos valores de entrada mas em ordem não decrescente.


## Ordenação

<div class="columns">
<div class="column" width="48%">

\scriptsize

```scheme
;; ListaDeNúmeros -> ListaDeNúmeros
;; Devolve uma nova lista com os mesmos
;; elemento de lst em ordem não decrescente.
(examples
 (check-equal? (ordena empty)
               empty)
 (check-equal? (ordena (list 2))
               (list 2))
 (check-equal? (ordena (list 5 2))
               (list 2 5))
 (check-equal? (ordena (list 3 5 2))
               (list 2 3 5))
 (check-equal? (ordena (list 4 3 5 2))
               (list 2 3 4 5)))
```

\pause

</div>
<div class="column" width="48%">

\scriptsize

```scheme
(define (ordena lst)
  (cond
    [(empty? lst) empty]
    [else
      ...
      (first lst)
      (ordena (rest lst))]))
```

\pause

\normalsize

Como combinamos o resultado da chamada recursiva com o primeiro elemento? \pause Inserimos o primeiro elemento de forma ordenada.
</div>
</div>



## Ordenação

<div class="columns">
<div class="column" width="48%">

\scriptsize

```scheme
(define (ordena lst)
  (cond
    [(empty? lst) empty]
    [else
      (insere-ordenado
        (first lst)
        (ordena (rest lst)))]))
```

\pause

\normalsize

Podemos usar `map` , `filter` ou `foldr` para implementar a função ordena? \pause Sim, podemos usar o `foldr`! \pause

</div>
<div class="column" width="48%">

\scriptsize

```scheme
(define (ordena lst)
  (foldr insere-ordenado empty lst))
```

\scriptsize

</div>
</div>



Definições locais e fechamentos
===============================

## Definições locais e fechamentos

Considere as seguintes definições

```scheme
(define (soma x) (+ x 5))

(define (lista-soma5 lst)
  (map soma lst))
```

\pause

Existem dois aspectos sobre neste código que podemos melhorar, quais são eles? \pause

- A função `soma` tem um uso bastante restrito (supomos que ela é utilizada apenas pela função `lista-soma5`), mas foi declarada em um escopo global utilizando um nome fácil de ter conflito (outro programador pode escolher o nome `soma` para outra função); \pause

- A função `lista-soma5` é bastante específica e pode ser generalizada.


## Definições locais e fechamentos

O primeiro problema pode ser resolvido colocando a definição de `soma` dentro da função `lista-soma5`, desta forma a função `soma` é visível apenas para `lista-soma5`. Isto melhora o encapsulamento e libera o nome `soma`

\pause

```scheme
(define (lista-soma5 lst)
  (define (soma x)
    (+ x 5))
  (map soma lst))
```

\pause

Este tipo de definição é chamada de **definição interna**.


## Definições locais e fechamentos

O segundo problema pode ser resolvido adicionado um parâmetro `n` e mudando o nome da função `lista-soma5` para `lista-soma-n` \pause

```scheme
(define (lista-soma-n n lst)
  (define (soma x)
    (+ x n))
  (map soma lst))
```

\pause

Existe algo diferente na função `soma`? \pause Sim, `soma` utiliza a variável `n`, que não é um parâmetro e nem uma variável local dentro de `soma`.


## Definições locais e fechamentos

Uma **variável livre** em relação a uma função é aquela que não é um parâmetro da função e nem foi declarada localmente dentro da função. \pause

Como uma função acessa um parâmetro ou uma variáveis local? \pause Geralmente, consultando o registro de ativação, o quadro, da sua chamada. \pause

Como `soma` acessa a variável livre `n` já que ela não é armazenada no registro de ativação de `soma`? \pause

A função `soma` deve "levar" junto com ela a variável livre `n`.


## Definições locais e fechamentos

O **ambiente léxico** é uma tabela com referências para as variáveis livres. \pause

Um **fechamento** (*closure* em inglês) é uma função junto com o seu ambiente léxico. \pause

No caso

```scheme
(define (lista-soma-n n lst)
  (define (soma x)
    (+ x n))
  (map soma lst))
```

quando `soma` é utilizada na chamada do `map` um fechamento é passado como parâmetro.


## Definições locais e fechamentos

Definições internas também são usadas para evitar computar a mesma expressão mais que uma vez.


## Definições locais e fechamentos

Considere por exemplo esta função que remove os elementos consecutivos iguais

\small

```scheme
(define (remove-duplicados lst)
  (cond
    [(empty? lst) empty]
    [(empty? (rest lst)) lst]
    [else
     (if (equal? (first lst)
                 (first (remove-duplicados (rest lst))))
         (remove-duplicados (rest lst))
         (cons (first lst)
               (remove-duplicados (rest lst))))]))
```

As expressões `(first lst)` e `(remove-duplicados (rest lst))` são computadas duas vezes.


## Definições locais e fechamentos

Criando definições internas obtemos

```scheme
(define (remove-duplicados lst)
  (cond
    [(empty? lst) empty]
    [(empty? (rest lst)) lst]
    [else
     (define p (first lst))
     (define r (remove-duplicados (rest lst)))
     (if (equal? p (first r))
         r
         (cons p r))]))
```

Desta forma as expressões são computadas apenas uma vez.


## Definições locais e fechamentos

O `define`{.scheme} não pode ser usado em alguns lugares, como por exemplo no consequente ou alternativa do `if`{.scheme}.

Em geral utilizamos `define`{.scheme} apenas no início da função, em outros lugares utilizamos a forma especial `let`{.scheme}.


## Definições locais e fechamentos

A sintaxe do `let`{.scheme} é

```scheme
(let ([var1 exp1]
      [var2 exp2]
      ...
      [varn expn])
  corpo)
```

Os nomes `var1`, `var2`, ..., são locais ao `let`{.scheme}, ou seja, são visíveis apenas no corpo do `let`{.scheme}.

O resultado da avaliação do `corpo` é o resultado da expressão `let`{.scheme}.


## Definições locais e fechamentos

No `let`{.scheme} os nomes que estão sendo definidos não podem ser usados nas definições dos nomes seguintes, por exemplo, não é possível utilizar o nome `var1` na expressão de `var2`.

`let*`{.scheme} não tem essa limitação


## Definições locais e fechamentos

Definições internas com o `let`{.scheme}

```scheme
(define (remove-duplicados lst)
  (cond
    [(empty? lst) empty]
    [(empty? (rest lst)) lst]
    [else
     (let ([p (first lst)]
           [r (remove-duplicados (rest lst))])
       (if (equal? p (first r))
           r
           (cons p r)))]))
```


## Exemplo

Defina a função `mapeia` em termos da função `reduz`.


## `mapeia` em termos de `reduz`

```scheme
(define (mapeia f lst)
  (define (cons-f e lst)
    (cons (f e) lst))
  (reduz cons-f empty lst))
```


## Exemplo

Defina a função `filtra` em termos da função `reduz`.


## `filtra` em termos de `reduz`

```scheme
(define (filtra pred? lst)
  (define (cons-if e lst)
    (if (pred? e) (cons e lst) lst))
  (reduz cons-if empty lst))
```



Funções anônimas
================

## Funções anônimas

Da mesma forma que podemos utilizar expressões aritméticas sem precisar nomeá-las, também podemos utilizar expressões que resultam em funções sem precisar nomeá-las


## Funções anônimas

Quando fazemos um `define` de uma função, estamos especificando duas coisas:  **a função** e **o nome da função**. Quando escrevemos

```scheme
(define (quadrado x)
  (* x x))
```

O Racket interpreta como

```scheme
(define quadrado
  (lambda (x) (* x x)))
```

O que deixa claro a distinção entre criar a função e dar nome à função. Às vezes é útil definir uma função sem dar nome a ela.


## Funções anônimas

`lambda`{.scheme} é a palavra chave usada para especificar funções. A sintaxe do `lambda`{.scheme} é

```scheme
(lambda (parametros ...)
    corpo)
```

Em vez de utilizar a palavra `lambda`{.scheme}, podemos utilizar a letra $\lambda$ (ctrl + \textbackslash no DrRacket)


## Funções anônimas

Como e quando utilizar uma função anônima? \pause

- Como parâmetro, quando a função for pequena e necessária apenas naquele local \pause

    ```scheme
    > (map (λ (x) (* x 2)) (list 3 8 -6))
    '(6 16 -12)
    > (filter (λ (x) (< x 10)) (list 3 20 -4 50))
    '(3 -4)
    ```

\pause

- Como resultado de função



Funções que produzem funções
============================

## Funções que produzem funções

Como identificar a necessidade de criar e utilizar funções que produzem funções? \pause

- Parametrizar a criação de funções fixando alguns parâmetros \pause

- Composição de funções \pause

- ... \pause

- Requer experiência


## Exemplo: somador

Defina uma função que receba um parâmetro $n$ e devolva uma função que soma o seu argumento a $n$.


## Exemplo: somador

```scheme
> (define soma1 (somador 1))
> (define soma5 (somador 5))
> (soma1 4)
5
> (soma5 9)
14
> (soma1 6)
7
> (soma5 3)
8
```


## Exemplo: somador

```scheme
;; Número -> (Número -> Número)
;; Devolve uma função que recebe um parâmetro x
;; e produz a soma de n e x.
(examples
 (check-equal? ((somador 4) 3) 7)
 (check-equal? ((somador -2) 8) 6))
(define (somador n) ...)
```

\pause

```scheme
;; Versão com função nomeada.
(define (somador n)
  (define (soma x)
    (+ n x))
  soma)
```


## Exemplo: somador

```scheme
;; Número -> (Número -> Número)
;; Devolve uma função que recebe um parâmetro x
;; e produz a soma de n e x.
(examples
 (check-equal? ((somador 4) 3) 7)
 (check-equal? ((somador -2) 8) 6))
(define (somador n) ...)
```

\pause

```scheme
;; Versão com função anônima.
(define (somador n)
  (λ (x) (+ n x)))
```


## Exemplo: negação

Defina uma função que receba como parâmetro um predicado (função que retorna booleano) e retorne uma função que retorna a negação do predicado.

- `negate` ([referência](https://docs.racket-lang.org/reference/procedures.html#%28def._%28%28lib._scheme%2Ffunction..rkt%29._negate%29%29))


## Exemplo: negação

```scheme
> ((nega positive?) 3)
#f
> ((nega positive?) -3)
#t
> ((nega even?) 4)
#f
> ((nega even?) 3)
#t
```


## Exemplo: negação

```scheme
;; (X -> Boolean) -> (X -> Boolean)
;; Devolve uma função que é semelhante a pred,
;; mas que devolve a  negação do resultado de pred.
;; Veja a função pré-definida negate.
(examples
 (check-equal? ((nega positive?) 3) #f)
 (check-equal? ((nega positive?) -3) #t)
 (check-equal? ((nega even?) 4) #f)
 (check-equal? ((nega even?) 3) #t))
```

\pause

```scheme
(define (nega pred?)
  (λ (x) (not (pred? x))))
```



Currying
========


## Currying

No cálculo lambda o currying permite definir funções que admitem múltiplos parâmetros. \pause

Aqui o currying permite a aplicação parcial das funções. \pause

Por exemplo, para uma função que admite dois argumentos, poderemos aplicá-la apenas ao primeiro argumento e mais tarde ao segundo argumento, resultando no valor esperado.


## Currying

```scheme
> (define f (λ (x) (λ (y) (* x y))))
> (define ((g x) y) (< x y))
> (map (f 2) (list 1 2 3 4))
'(2 4 6 8)
> (filter (g 2) (list 1 2 3 4))
'(3 4)
```


## `curry` e `curryr`

As funções pré-definidas `curry` e `curryr` são utilizadas para fixar argumentos de funções

- `curry` fixa os argumentos da esquerda para direita

- `curryr` fixa os argumentos da direita para esquerda


## `curry` e `curryr`

```scheme
> (define e-4? (curry = 4))
> (e-4? 4)
#t
> (e-4? 5)
#f
> (filter e-4? (list 3 4 7 4 6))
'(4 4)
> (filter (curry < 3) (list 4 3 2 5 7 1))
'(4 5 7)
> (filter (curryr < 3) (list 4 3 2 5 7 1))
'(2 1)
> (map (curry + 5) (list 3 6 2))
'(8 11 7)
```


## Exemplo: quicksort

Defina uma função que ordene uma lista de números distintos usando o algoritmo de ordenação _quicksort_.


## Exemplo: quicksort

\small

```scheme
;; Lista(Número) -> Lista(Número)
;; Ordena uma lista de números usando o quicksort.
(examples
 (check-equal? (quicksort empty)
               empty)
 (check-equal? (quicksort (list 3))
               (list 3))
 (check-equal? (quicksort (list 10 3 -4 5 9))
               (list -4 3 5 9 10))
 (check-equal? (quicksort (list 3 10 0 5 9))
               (list 0 3 5 9 10)))
```


## Exemplo: quicksort

Como começar a implementação? \pause Usando o modelo baseado na definição de lista? \pause Não! \pause

Se fizermos a implementação baseada no modelo vamos chegar no algoritmo de ordenação por inserção, como de fato já fizemos. \pause Aqui temos que implementar o algoritmo _quicksort_, que tem um funcionamento específico. \pause

Qual é a ideia do _quicksort_? \pause

- Selecionar um elemento da entrada como pivô. \pause

- Separar os elementos menores que o pivô e ordená-los recursivamente. \pause

- Separar os elementos maiores que o pivô e ordená-los recursivamente. \pause

- Juntar a ordenação dos menores, com o pivô e com os maiores.


## Exemplo: quicksort

\small

```scheme
(define (quicksort lst)
  (if (empty? lst)
      empty
      (let ([pivo (first lst)])
        (append (quicksort (filter (curryr < pivo) lst))
                (list pivo)
                (quicksort (filter (curryr > pivo) lst))))))
```


## Recursão natural vs generativa

Qual a diferença na forma da recursão utilizada no _quicksort_ em relação as recursões do exemplos anteriores? \pause

Nos exemplos anteriores, a recursão era feita para o resto da lista, já no _quicksort_, a recursão é feita para listas criadas a partir da lista de entrada. \pause

Em uma **recursão estrutural**, as chamadas recursivas são feitas em componentes das entradas. \pause

Em uma **recursão generativa**, as chamadas recursivas são feitas em dados gerados/construídos a partir da entrada.


Outras funções de alta ordem
============================

## Outras funções de alta ordem

- `apply` ([referência](http://docs.racket-lang.org/reference/procedures.html?q=apply#%28def._%28%28lib._scheme%2Fprivate%2Fbase..rkt%29._apply%29%29))

    ```scheme
    > (apply < (list 4 5))
    #t
    > (apply + (list 4 5))
    9
    > (apply * (list 2 3 4))
    24
    ```

- `andmap` ([referência](http://docs.racket-lang.org/reference/pairs.html#%28def._%28%28lib._scheme/private/map..rkt%29._andmap%29%29))

- `ormap` ([referência](http://docs.racket-lang.org/reference/pairs.html#%28def._%28%28lib._scheme/private/map..rkt%29._ormap%29%29))

- `build-list` ([referência](http://docs.racket-lang.org/reference/pairs.html#%28def._%28%28lib._scheme/private/list..rkt%29._build-list%29%29))



Funções com número variado de parâmetros
========================================

## Funções com número variado de parâmetros

Muitas funções pré-definidas aceitam um número variado de parâmetros. \pause Como criar funções com esta característica? \pause

Forma geral

```scheme
(define (nome obrigatorios . opcionais) corpo)
(define (nome . opcionais) corpo)
(λ (obrigatorios . opcionais) corpo)
(λ opcionais corpo)
```

Os parâmetros opcionais são agrupados em uma lista


## Funções com número variado de parâmetros

Exemplos

```scheme
> (define (f1 p1 p2 . outros) outros)
> (f1 4 5 7 -2 5)
'(7 -2 5)
> (f1 4 5)
'()
> (f1 4)
f1: arity mismatch;
 the expected number of arguments does not match the given number
  expected: at least 2
  given: 1
  arguments...:
   4
```



Referências
===========

## Referências

Básicas

- Vídeos [Abstractions](https://www.youtube.com/playlist?list=PL6NenTZG6KroSmESv5ItvLft76ZR8q-Nd)

- Texto "From Examples" do curso [Introduction to Systematic Program Design - Part 1](https://class.coursera.org/programdesign-002/wiki/view?page=UsingAbstractFunctions) (Necessário inscrever-se no curso)

- Capítulos [14](https://htdp.org/2022-8-7/Book/part_three.html#%28part._ch~3add-similarities%29) e [15](https://htdp.org/2022-8-7/Book/part_three.html#%28part._ch~3aabstract%29) do livro [HTDP](http://htdp.org)

- Seções [3.9](http://docs.racket-lang.org/reference/pairs.html) e [3.17](http://docs.racket-lang.org/reference/procedures.html) da [Referência Racket](http://docs.racket-lang.org/reference/)

Complementares

- Seções [1.3](https://mitpress.mit.edu/sicp/full-text/book/book-Z-H-12.html#%_sec_1.3) (1.3.1 e 1.3.2)   e [2.2.3](https://mitpress.mit.edu/sicp/full-text/book/book-Z-H-15.html#%_sec_2.2.3) do livro [SICP](https://mitpress.mit.edu/sicp/)

- Seções [4.2](http://www.scheme.com/tspl4/binding.html#./binding:h2) e [5.5](http://www.scheme.com/tspl4/control.html#./control:h5) do livro [TSPL4](http://www.scheme.com/tspl4/)
