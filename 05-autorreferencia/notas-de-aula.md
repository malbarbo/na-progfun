---
# vim: set spell spelllang=pt_br sw=4:
# TODO: renomear para autorreferências (no plural)
title: Autorreferência
---


Introdução
==========

## Introdução

Projete uma função que some uma sequência de números. \pause

Como representar e processar uma quantidade de dados arbitrária? \pause

- Vamos criar tipos de dados com autorreferência, isto é, tipos de dados que são definidos em termos deles mesmos \pause

- Vamos usar funções recursivas para processar dados com autorreferência



Listas
======


## Listas

O tipo de dado com autorreferência mais comum nas linguagens funcionais é a lista. \pause

Vamos tentar criar uma definição para lista de números.


## Listas

A ideia é criar uma estrutura com dois campos. O primeiro campo representa um valor na lista e o segundo campo representa o restante da lista (que é uma lista). \pause

```scheme
(struct lista (primeiro resto) #:transparent)
;; Representa uma lista de números
;;  primeiro: Número - é o primeiro elemento
;;                     da lista
;;  resto:    Lista  - é o restante da lista
```


## Listas

Utilizando esta definição, vamos tentar representar uma lista com os valores  4, 2 e 8. \pause

```scheme
(define ldn (lista 4 (lista 2 (lista 8 ???))))
```

\pause

O problema com esta definição é que ela não tem fim. Uma lista é definida em termos de outra lista, que é definida em termos de outra lista, etc.


## Listas

Precisamos de uma maneira de criar uma lista diretamente, que não seja em termos de outra lista. Que lista pode ser essa? \pause

A lista vazia.


## Listas

Uma **ListaDeNúmeros** é um dos valores: \pause

- `(vazia)`; ou \pause

- `(link Número ListaDeNúmeros)`, onde link é uma estrutura com dois campos: `primeiro` e `resto` \pause

Definição no Racket

```scheme
(struct vazia () #:transparent)

(struct link (primeiro resto) #:transparent)
;; Uma ListaDeNúmeros é um dos valores
;;   - (vazia); ou
;;   - (link Numero ListaDeNúmeros)
```


## Listas

\footnotesize

```scheme
> (define ldn1 (link 3 (vazia)))          ; Lista com o 3
> (define ldn2 (link 8 (link 7 (vazia)))) ; Lista com o 8 e 7
> ldn1
(link 3 (vazia))
> ldn2
(link 8 (link 7 (vazia)))
> (link-primeiro ldn2)
8
> (link-resto ldn2)
(link 7 (vazia))
> (link-resto ldn1)
(vazia)
> (link-primeiro (link-resto ldn1))
. . link-primeiro: contract violation
  expected: link?
  given: (vazia)
```


## Listas

\footnotesize

```scheme
;; Lista com os elementos 8 e 7
> (define ldn2 (link 8 (link 7 (vazia))))
;; Define uma lista a partir de uma lista existente
> (define ldn3 (link 4 ldn2))
> ldn3
(link 4 (link 8 (link 7 (vazia))))
> (link-primeiro ldn3)
4
> (link-resto ldn3)
(link 8 (link 7 (vazia)))
> (link-primeiro (link-resto ldn3))
8
```


## Listas

Nós vimos anteriormente que a forma do dado de entrada de uma função sugere uma forma para o corpo da função. \pause

Qual é a forma para o corpo de uma função que o tipo da entrada ListaDeNúmeros sugere?


## Listas

Uma condicional com dois casos: \pause

- A lista é vazia \pause
- A lista é um link \pause

Em Racket \pause

```scheme
(define (fn-para-ldn ldn)
  (cond
    [(vazia? ldn) ...]
    [else
     (... (link-primeiro ldn)
          (link-resto ldn))]))
```


## Listas

Qual é o resultado de `(link-primeiro ldn)`? \pause Um número, que é um valor atômico. \pause

Qual o resultado de `(link-rest ldn)`? \pause Uma lista, que é uma união. \pause

Um valor atômico pode ser processado diretamente, mas como processar uma lista? \pause Fazendo análise dos casos... \pause

Vamos fazer uma alteração no modelo `fn-para-ldn` e adicionar uma chamada recursiva para processar `(link-resto ldn)`. Essa alteração pode parecer meio "mágica" no início, mas ela vai ficar mais clara no futuro.


## Listas

Modelo para funções que a entrada é ListaDeNúmeros

```scheme
(define (fn-para-ldn ldn)
  (cond
    [(vazia? ldn) ...]
    [else
     (... (link-primeiro ldn)
          (fn-para-ldn (link-resto ldn)))]))
```

\pause

Observe a relação com a definição de `ListaDeNúmeros`

- A definição tem dois casos, o modelo também

- A autorreferência na definição do dado sugere uma chamada recursiva no modelo



## Exemplo: soma

Defina uma função que some os valores de uma lista de números.


## Exemplo: soma

Especificação

\small

```scheme
;; ListaDeNúmeros -> Número
;; Soma os valores de ldn.
(examples
 (check-equal? (soma (vazia)) 0)
 (check-equal? (soma (link 3 (vazia))) 3) ; (+ 3 0)
 (check-equal? (soma (link 2 (link 5 (vazia)))) 7)) ; (+ 2 (+ 5 0))
 (check-equal? (soma (link 4 (link 1 (link 3 (vazia))))) 8)) ; (+ 4 (+ 1 (+ 3 0)))

(define (soma ldn) 0)
```

\pause

\normalsize

E agora, como escrevemos a implementação? \pause Vamos partir do modelo que criamos!

## Exemplo: soma

<div class="columns">
<div class="column" width="68%">
\footnotesize

```scheme
;; ListaDeNúmeros -> Número
;; Soma os valores de ldn.
(examples
 (check-equal? (soma (vazia)) 0)
 (check-equal? (soma (link 3 (vazia))) 3) ; (+ 3 0)
 (check-equal? (soma (link 2 (link 5 (vazia)))) 7))
 ; (+ 2 (+ 5 0))
 (check-equal? (soma (link 4 (link 1 (link 3 (vazia))))) 8))
 ; (+ 4 (+ 1 (+ 3 0)))

(define (fn-para-ldn ldn)
  (cond
    [(vazia? ldn) ...]
    [else
     (... (link-primeiro ldn)
          (fn-para-ldn (link-resto ldn)))]))
```
\pause
</div>
<div class="column" width="28%">
O que fazemos agora? \pause

Mudamos o nome da função tanto na definição quanto na chamada recursiva.
</div>
</div>

## Exemplo: soma

<div class="columns">
<div class="column" width="68%">
\footnotesize

```scheme
;; ListaDeNúmeros -> Número
;; Soma os valores de ldn.
(examples
 (check-equal? (soma (vazia)) 0)
 (check-equal? (soma (link 3 (vazia))) 3) ; (+ 3 0)
 (check-equal? (soma (link 2 (link 5 (vazia)))) 7))
 ; (+ 2 (+ 5 0))
 (check-equal? (soma (link 4 (link 1 (link 3 (vazia))))) 8))
 ; (+ 4 (+ 1 (+ 3 0)))

(define (soma ldn)
  (cond
    [(vazia? ldn) ...]
    [else
     (... (link-primeiro ldn)
          (soma (link-resto ldn)))]))
```
\pause
</div>
<div class="column" width="28%">
O que fazemos agora? \pause

Vamos preencher as lagunas. \pause Qual deve ser o resultado quando a lista é vazia? \pause 0.
</div>
</div>


## Exemplo: soma

<div class="columns">
<div class="column" width="68%">
\footnotesize

```scheme
;; ListaDeNúmeros -> Número
;; Soma os valores de ldn.
(examples
 (check-equal? (soma (vazia)) 0)
 (check-equal? (soma (link 3 (vazia))) 3) ; (+ 3 0)
 (check-equal? (soma (link 2 (link 5 (vazia)))) 7))
 ; (+ 2 (+ 5 0))
 (check-equal? (soma (link 4 (link 1 (link 3 (vazia))))) 8))
 ; (+ 4 (+ 1 (+ 3 0)))

(define (soma ldn)
  (cond
    [(vazia? ldn) 0]
    [else
     (... (link-primeiro ldn)
          (soma (link-resto ldn)))]))
```
\pause
</div>
<div class="column" width="28%">
O que fazemos agora? \pause

Analisamos o caso em que a lista não é vazia. O modelo está sugerindo fazer a chamada recursiva para o resto da lista. \pause

Aqui vem o ponto crucial! Mesmo a função não estando completa, nós vamos assumir que ela produz a resposta correta para o resto da lista.

</div>
</div>

## Exemplo: soma

<div class="columns">
<div class="column" width="68%">
\footnotesize

```scheme
;; ListaDeNúmeros -> Número
;; Soma os valores de ldn.
(examples
 (check-equal? (soma (vazia)) 0)
 (check-equal? (soma (link 3 (vazia))) 3) ; (+ 3 0)
 (check-equal? (soma (link 2 (link 5 (vazia)))) 7))
 ; (+ 2 (+ 5 0))
 (check-equal? (soma (link 4 (link 1 (link 3 (vazia))))) 8))
 ; (+ 4 (+ 1 (+ 3 0)))

(define (soma ldn)
  (cond
    [(vazia? ldn) 0]
    [else
     (... (link-primeiro ldn)
          (soma (link-resto ldn)))]))
```
</div>
<div class="column" width="28%">
Agora temos o primeiro elemento e a soma do resto da lista, como podemos combinar esses dois valores para obter a soma dos elementos da lista? \pause Somando.

</div>
</div>

## Exemplo: soma

\footnotesize

```scheme
;; ListaDeNúmeros -> Número
;; Soma os valores de ldn.
(examples
 (check-equal? (soma (vazia)) 0)
 (check-equal? (soma (link 3 (vazia))) 3) ; (+ 3 0)
 (check-equal? (soma (link 2 (link 5 (vazia)))) 7))
 ; (+ 2 (+ 5 0))
 (check-equal? (soma (link 4 (link 1 (link 3 (vazia))))) 8))
 ; (+ 4 (+ 1 (+ 3 0)))

(define (soma ldn)
  (cond
    [(vazia? ldn) 0]
    [else
     (+ (link-primeiro ldn)
        (soma (link-resto ldn)))]))
```


## Exemplo: soma

Verificação: Ok.

Revisão: exercício.


## Listas

O Racket já vem com listas pré-definidas

- `empty` ao invés de `(vazia)`

- `cons` ao invés de `link`

- `first` ao invés de `link-primeiro`

- `rest` ao invés de `link-resto`

Outras funções (os propósitos são aproximados)

- `empty?` verifica se uma lista é vazia

- `cons?` verifica se uma lista não é vazia

- `list?` verifica se um valor é uma lista


## Listas

Uma **ListaDeNúmeros** é um dos valores

- `empty`; ou

- `(cons Número ListaDeNúmeros)`


## Listas


```scheme
;; Modelo para funções com entrada ListaDeNúmeros
#;
(define (fn-para-ldn ldn)
  (cond
    [(empty? ldn) ...]
    [else ... (first ldn)
          ... (fn-para-ldn (rest ldn)) ... ]))
```


## Listas

\footnotesize

```scheme
> (define ldn1 (cons 3 empty)) ; Lista com o elemento 3
> (define ldn2 (cons 8 (cons 7 empty))) ; Lista com 8 e 7
> ldn1
'(3)
> ldn2
'(8 7)
> (first ldn2)
8
> (rest ldn2)
'(7)
> (rest (rest ldn2))
'()
> (first (rest ldn1))
. . first: contract violation
  expected: (and/c list? (not/c empty?))
    given: '()
```


## Listas

\footnotesize

```scheme
;; Lista com os elementos 8 e 7
> (define ldn2 (cons 8 (cons 7 empty)))
;; Defini uma lista a partir de uma lista existente
> (define ldn3 (cons 4 ldn2))
> ldn3
'(4 8 7)
> (first ldn3)
4
> (rest ldn3)
'(8 7)
> (first (rest ldn3))
8
```


## Listas

O Racket oferece uma forma conveniente de criar listas \pause

```scheme
> (list 4 5 6 -2 20)
'(4 5 6 -2 20)
```

\pause

Em geral

```scheme
(list <a1> <a2> ... <an>)
```

é equivalente a

```scheme
(cons <a1>
      (cons <a2>
            (cons ...
                  (cons <an> empty) ...)))
```


## Exemplo: contém

Defina uma função que verifique se um dado valor está em uma lista de números.


## Exemplo: contém

<div class="columns">
<div class="column" width="68%">
\footnotesize

```scheme
;; ListaDeNúmeros Número -> Booleano
;; Produz #t se v está em ldn; #f caso contrário.
(examples
 (check-equal? (contem? empty 3) #f)
 (check-equal? (contem? (cons 3 empty) 3) #t)
 (check-equal? (contem? (cons 3 empty) 4) #f)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 4) #t)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 10) #t)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 8) #f))

(define (contem? ldn v) #f)





```
</div>
<div class="column" width="28%">
Iniciamos com a especificação.
</div>
</div>


## Exemplo: contém

<div class="columns">
<div class="column" width="68%">
\footnotesize

```scheme
;; ListaDeNúmeros Número -> Booleano
;; Produz #t se v está em ldn; #f caso contrário.
(examples
 (check-equal? (contem? empty 3) #f)
 (check-equal? (contem? (cons 3 empty) 3) #t)
 (check-equal? (contem? (cons 3 empty) 4) #f)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 4) #t)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 10) #t)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 8) #f))

(define (fn-para-ldn ldn)
  (cond
    [(empty? ldn) ...]
    [else
      ... (first ldn)
      ... (fn-para-ldn (rest ldn)) ... ]))
```
</div>
<div class="column" width="28%">
Para implementação partimos do modelo.
</div>
</div>


## Exemplo: contém

<div class="columns">
<div class="column" width="68%">
\footnotesize

```scheme
;; ListaDeNúmeros Número -> Booleano
;; Produz #t se v está em ldn; #f caso contrário.
(examples
 (check-equal? (contem? empty 3) #f)
 (check-equal? (contem? (cons 3 empty) 3) #t)
 (check-equal? (contem? (cons 3 empty) 4) #f)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 4) #t)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 10) #t)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 8) #f))

(define (contem? ldn v)
  (cond
    [(empty? ldn) ... v]
    [else
      ... (first ldn)
      ... (contem? (rest ldn) v) ... ]))
```
</div>
<div class="column" width="28%">
Em seguida ajeitamos o nome da função e adicionamos o parâmetro `v`.
</div>
</div>


## Exemplo: contém

<div class="columns">
<div class="column" width="68%">
\footnotesize

```scheme
;; ListaDeNúmeros Número -> Booleano
;; Produz #t se v está em ldn; #f caso contrário
(examples
 (check-equal? (contem? empty 3) #f)
 (check-equal? (contem? (cons 3 empty) 3) #t)
 (check-equal? (contem? (cons 3 empty) 4) #f)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 4) #t)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 10) #t)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 8) #f))

(define (contem? ldn v)
  (cond
    [(empty? ldn) #f]
    [else
      ... (first ldn)
      ... (contem? (rest ldn) v) ... ]))
```
</div>
<div class="column" width="28%">
Analisando os exemplos definimos o caso em que a lista é vazia.
</div>
</div>


## Exemplo: contém

<div class="columns">
<div class="column" width="68%">
\footnotesize

```scheme
;; ListaDeNúmeros Número -> Booleano
;; Produz #t se v está em ldn; #f caso contrário
(examples
 (check-equal? (contem? empty 3) #f)
 (check-equal? (contem? (cons 3 empty) 3) #t)
 (check-equal? (contem? (cons 3 empty) 4) #f)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 4) #t)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 10) #t)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 8) #f))

(define (contem? ldn v)
  (cond
    [(empty? ldn) #f]
    [else
     (if (= v (first ldn))
         #t
         (contem? (rest ldn) v))]))
```
</div>
<div class="column" width="28%">
Analisando os exemplos definimos o caso em que a lista não é vazia.
</div>
</div>


## Exemplo: contém

<div class="columns">
<div class="column" width="68%">
\footnotesize

```scheme
;; ListaDeNúmeros Número -> Booleano
;; Produz #t se v está em ldn; #f caso contrário
(examples
 (check-equal? (contem? empty 3) #f)
 (check-equal? (contem? (cons 3 empty) 3) #t)
 (check-equal? (contem? (cons 3 empty) 4) #f)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 4) #t)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 10) #t)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 8) #f))

(define (contem? ldn v)
  (cond
    [(empty? ldn) #f]
    [else
     (or (= v (first ldn))
         (contem? (rest ldn) v))]))
```
</div>
<div class="column" width="28%">
Revisão.
</div>
</div>


## Exemplo: remove negativos

Defina uma função que remova todos os número negativos de uma lista de números.


## Exemplo: remove negativos (especificação)

<div class="columns">
<div class="column" width="68%">
\footnotesize

```scheme
;; ListaDeNúmeros -> ListaDeNúmeros
;; Produz uma nova lista removendo os valores negativos de ldn.
(examples
 (check-equal? (remove-negativos empty) empty)
 (check-equal? (remove-negativos (cons -1 (cons 2 (cons -3 empty))))
               (cons 2 empty))
 (check-equal? (remove-negativos (cons 3 (cons 4 (cons -2 empty))))
               (cons 3 (cons 4 empty))))

(define (remove-negativos ldn) empty)







```
</div>
<div class="column" width="28%">
Iniciamos com a especificação.
</div>
</div>


## Exemplo: remove negativos

<div class="columns">
<div class="column" width="68%">
\footnotesize

```scheme
;; ListaDeNúmeros -> ListaDeNúmeros
;; Produz uma nova lista removendo os valores negativos de ldn.
(examples
 (check-equal? (remove-negativos empty) empty)
 (check-equal? (remove-negativos (cons -1 (cons 2 (cons -3 empty))))
               (cons 2 empty))
 (check-equal? (remove-negativos (cons 3 (cons 4 (cons -2 empty))))
               (cons 3 (cons 4 empty))))

(define (remove-negativos ldn)
  (cond
    [(empty? ldn) ...]
    [else
      ... (first ldn)
      ... (remove-negativos (rest ldn)) ... ]))


```
</div>
<div class="column" width="28%">
Para implementação partimos do modelo e ajustamos o nome.
</div>
</div>


## Exemplo: remove negativos

<div class="columns">
<div class="column" width="68%">
\footnotesize

```scheme
;; ListaDeNúmeros -> ListaDeNúmeros
;; Produz uma nova lista removendo os valores negativos de ldn.
(examples
 (check-equal? (remove-negativos empty) empty)
 (check-equal? (remove-negativos (cons -1 (cons 2 (cons -3 empty))))
               (cons 2 empty))
 (check-equal? (remove-negativos (cons 3 (cons 4 (cons -2 empty))))
               (cons 3 (cons 4 empty))))

(define (remove-negativos ldn)
  (cond
    [(empty? ldn) empty]
    [else
      ... (first ldn)
      ... (remove-negativos (rest ldn)) ... ]))


```
</div>
<div class="column" width="28%">
Analisando os exemplos definimos o caso em que a lista é vazia.
</div>
</div>


## Exemplo: remove negativos

<div class="columns">
<div class="column" width="68%">
\footnotesize

```scheme
;; ListaDeNúmeros -> ListaDeNúmeros
;; Produz uma nova lista removendo os valores negativos de ldn.
(examples
 (check-equal? (remove-negativos empty) empty)
 (check-equal? (remove-negativos (cons -1 (cons 2 (cons -3 empty))))
               (cons 2 empty))
 (check-equal? (remove-negativos (cons 3 (cons 4 (cons -2 empty))))
               (cons 3 (cons 4 empty))))

(define (remove-negativos ldn)
  (cond
    [(empty? ldn) empty]
    [else
     (if (< (first ldn) 0)
         (remove-negativos (rest ldn))
         (cons (first ldn)
               (remove-negativos (rest ldn))))]))
```
</div>
<div class="column" width="28%">
Analisando os exemplos definimos o caso em que a lista não é vazia.
</div>
</div>


## Exemplo: remove negativos

Verificação: Ok.

Revisão: exercício.


## Exemplo: soma x

Defina uma função que soma um valor `x` em cada elemento de uma lista de números.


## Exemplo: soma x (especificação)

<div class="columns">
<div class="column" width="68%">
\footnotesize

```scheme
;; ListaDeNúmeros Número -> ListaDeNúmeros
;; Produz uma nova lista somando x a cada elemento de ldn.
(examples
 (check-equal? (soma-x empty 4)
               empty)
 (check-equal? (soma-x (cons 4 (cons 2 empty)) 5)
               (cons 9 (cons 7 empty)))
 (check-equal? (soma-x (cons 3 (cons -1 (cons 4 empty))) -2)
               (cons 1 (cons -3 (cons 2 empty)))))

(define (soma-x ldn x) empty)





```
</div>
<div class="column" width="28%">
Iniciamos com a especificação.
</div>
</div>


## Exemplo: soma x

<div class="columns">
<div class="column" width="68%">
\footnotesize

```scheme
;; ListaDeNúmeros Número -> ListaDeNúmeros
;; Produz uma nova lista somando x a cada elemento de ldn.
(examples
 (check-equal? (soma-x empty 4)
               empty)
 (check-equal? (soma-x (cons 4 (cons 2 empty)) 5)
               (cons 9 (cons 7 empty)))
 (check-equal? (soma-x (cons 3 (cons -1 (cons 4 empty))) -2)
               (cons 1 (cons -3 (cons 2 empty)))))

(define (soma-x ldn x)
  (cond
    [(empty? ldn) ... x]
    [else
      ... (first ldn)
      ... (soma-x (rest ldn) x) ... ]))
```
</div>
<div class="column" width="28%">
Para implementação partimos do modelo e ajustamos o nome e adicionamos o parâmetro `x`.
</div>
</div>


## Exemplo: soma x

<div class="columns">
<div class="column" width="68%">
\footnotesize

```scheme
;; ListaDeNúmeros Número -> ListaDeNúmeros
;; Produz uma nova lista somando x a cada elemento de ldn.
(examples
 (check-equal? (soma-x empty 4)
               empty)
 (check-equal? (soma-x (cons 4 (cons 2 empty)) 5)
               (cons 9 (cons 7 empty)))
 (check-equal? (soma-x (cons 3 (cons -1 (cons 4 empty))) -2)
               (cons 1 (cons -3 (cons 2 empty)))))

(define (soma-x ldn x)
  (cond
    [(empty? ldn) empty]
    [else
      ... (first ldn)
      ... (soma-x (rest ldn) x) ... ]))
```
</div>
<div class="column" width="28%">
Analisando os exemplos definimos o caso em que a lista é vazia.
</div>
</div>


## Exemplo: soma x

<div class="columns">
<div class="column" width="68%">
\footnotesize

```scheme
;; ListaDeNúmeros Número -> ListaDeNúmeros
;; Produz uma nova lista somando x a cada elemento de ldn.
(examples
 (check-equal? (soma-x empty 4)
               empty)
 (check-equal? (soma-x (cons 4 (cons 2 empty)) 5)
               (cons 9 (cons 7 empty)))
 (check-equal? (soma-x (cons 3 (cons -1 (cons 4 empty))) -2)
               (cons 1 (cons -3 (cons 2 empty)))))

(define (soma-x ldn x)
  (cond
    [(empty? ldn) empty]
    [else
     (cons (+ x (first ldn))
           (soma-x (rest ldn) x))]))
```
</div>
<div class="column" width="28%">
Analisando os exemplos definimos o caso em que a lista não é vazia.
</div>
</div>


## Exemplo: soma x

Verificação: Ok.

Revisão: Ok.



Números Naturais
================


## Introdução

Um número natural é atômico ou composto? \pause

- Atômico quando usado em operações aritméticas, comparações, etc \pause

- Composto quando uma iteração precisa ser feita baseado no valor do número

\pause

Se um número natural pode ser visto como dado composto \pause

- Quais são as partes que compõe o número? \pause

- Como (de)compor um número?


## Definição

Um número **Natural** é

- $0$; ou

- `(add1 n)` onde $n$ é um número **Natural**

\pause

Baseado nesta definição, criamos um modelo para funções com números naturais

```scheme
(define (fn-para-natural n)
  (cond
    [(zero? n) ...]
    [else
      (... n
           (fn-para-natural (sub1 n)))]))
```


## Definição

\footnotesize

```scheme
;; as funções add1, sub1 e zero? são pré-definidas

;; compõe um novo natural a partir de um existente
;; semelhante ao cons
> (add1 8)
9
;; decompõe um natural
;; semelhante ao rest
> (sub1 8)
7
;; verifica se um natural é 0
;; semelhante ao empty?
> (zero? 8)
#f
> (zero? 0)
#t
```


## Exemplo: soma naturais

Dado um número natural $n$, defina uma função que some os números naturais menores ou iguais a $n$.


## Exemplo: soma naturais

Especificação

\small

```scheme
;; Natural -> Natural
;; Soma todos os números naturais de 0 até n
(examples
 (check-equal? (soma-nat 0) 0)
 (check-equal? (soma-nat 1) 1)  ; (+ 1 0)
 (check-equal? (soma-nat 3) 6)) ; (+ 3 (+ 2 (+ 1 0)))
(define (soma-nat n) 0)






```


## Exemplo: soma naturais

Implementação: modelo.

\small

```scheme
;; Natural -> Natural
;; Soma todos os números naturais de 0 até n
(examples
 (check-equal? (soma-nat 0) 0)
 (check-equal? (soma-nat 1) 1)  ; (+ 1 0)
 (check-equal? (soma-nat 3) 6)) ; (+ 3 (+ 2 (+ 1 0)))
(define (soma-nat n)
  (cond
    [(zero? n) ...]
    [else
      (... n
           (soma-nat (sub1 n)))]))
```


## Exemplo: soma naturais

Implementação: o caso base.

\small

```scheme
;; Natural -> Natural
;; Soma todos os números naturais de 0 até n
(examples
 (check-equal? (soma-nat 0) 0)
 (check-equal? (soma-nat 1) 1)  ; (+ 1 0)
 (check-equal? (soma-nat 3) 6)) ; (+ 3 (+ 2 (+ 1 0)))
(define (soma-nat n)
  (cond
    [(zero? n) 0]
    [else
      (... n
           (soma-nat (sub1 n)))]))
```


## Exemplo: soma naturais

Implementação: o outro caso.

\small

```scheme
;; Natural -> Natural
;; Soma todos os números naturais de 0 até n
(examples
 (check-equal? (soma-nat 0) 0)
 (check-equal? (soma-nat 1) 1)  ; (+ 1 0)
 (check-equal? (soma-nat 3) 6)) ; (+ 3 (+ 2 (+ 1 0)))
(define (soma-nat n)
  (cond
    [(zero? n) 0]
    [else
      (+ n
         (soma-nat (sub1 n)))]))
```


## Exemplo: lista de números

Dado um número natural $n$, defina uma função que devolva a lista `(list 1 2 ... n-1 n)`.


## Exemplo: lista de números

Especificação

\small

```scheme
;; Natural -> ListaDeNúmeros
;; Cria uma lista com os valores 1 2 ... n-1 n
(examples
  (check-equal? (lista-num 0) empty)
  (check-equal? (lista-num 1) (cons 1 empty))
  (check-equal? (lista-num 3) (cons 1 (cons 2 (cons 3 empty)))))
(define (lista-num n) empty)





```


## Exemplo: lista de números

Implementação: modelo.

\small

```scheme
;; Natural -> ListaDeNúmeros
;; Cria uma lista com os valores 1 2 ... n-1 n
(examples
  (check-equal? (lista-num 0) empty)
  (check-equal? (lista-num 1) (cons 1 empty))
  (check-equal? (lista-num 3) (cons 1 (cons 2 (cons 3 empty)))))
(define (lista-num n)
  (cond
    [(zero? n) ...]
    [else
      (... n
           (lista-num (sub1 n)))]))
```


## Exemplo: lista de números

Implementação: caso base.

\small

```scheme
;; Natural -> ListaDeNúmeros
;; Cria uma lista com os valores 1 2 ... n-1 n
(examples
  (check-equal? (lista-num 0) empty)
  (check-equal? (lista-num 1) (cons 1 empty))
  (check-equal? (lista-num 3) (cons 1 (cons 2 (cons 3 empty)))))
(define (lista-num n)
  (cond
    [(zero? n) empty]
    [else
      (... n
           (lista-num (sub1 n)))]))
```


## Exemplo: lista de números

Implementação: o outro caso (veja o vídeo da aula para entender como chegamos nesse código).

\small

```scheme
;; Natural -> ListaDeNúmeros
;; Cria uma lista com os valores 1 2 ... n-1 n
(examples
  (check-equal? (lista-num 0) empty)
  (check-equal? (lista-num 1) (cons 1 empty))
  (check-equal? (lista-num 3) (cons 1 (cons 2 (cons 3 empty)))))
(define (lista-num n)
  (cond
    [(zero? n) empty]
    [else
      (cons-fim n
                (lista-num (sub1 n)))]))
```


## Exemplo: adiciona no final da lista

Especificação para `cons-fim`.

\small

```scheme
;; Número ListaDeNúmeros -> ListaDeNúmeros
;; Adiciona n ao final de ldn.
(define (cons-fim n ldn) ldn)









```


## Exemplo: adiciona no final da lista

Especificação para `cons-fim`.

\small

```scheme
;; Número ListaDeNúmeros -> ListaDeNúmeros
;; Adiciona n ao final de ldn.
(examples
  (check-equal? (cons-fim 3 empty) (cons 3 empty))
  (check-equal? (cons-fim 1 (cons 3 (cons 4 empty)))
                (cons 3 (cons 4 (cons 1 empty)))))
(define (cons-fim n ldn) ldn)





```


## Exemplo: adiciona no final da lista

Implementação: modelo.

\small

```scheme
;; Número ListaDeNúmeros -> ListaDeNúmeros
;; Adiciona n ao final de ldn.
(examples
  (check-equal? (cons-fim 3 empty) (cons 3 empty))
  (check-equal? (cons-fim 1 (cons 3 (cons 4 empty)))
                (cons 3 (cons 4 (cons 1 empty)))))
(define (cons-fim n ldn)
  (cond
    [(empty? ldn) ... n]
    [else
     (... (first ldn)
          (cons-fim n (rest ldn)))]))
```


## Exemplo: adiciona no final da lista

Implementação: caso base.

\small

```scheme
;; Número ListaDeNúmeros -> ListaDeNúmeros
;; Adiciona n ao final de ldn.
(examples
  (check-equal? (cons-fim 3 empty) (cons 3 empty))
  (check-equal? (cons-fim 1 (cons 3 (cons 4 empty)))
                (cons 3 (cons 4 (cons 1 empty)))))
(define (cons-fim n ldn)
  (cond
    [(empty? ldn) (cons n empty)]
    [else
     (... (first ldn)
          (cons-fim n (rest ldn)))]))
```


## Exemplo: adiciona no final da lista

Implementação: outro caso.

\small

```scheme
;; Número ListaDeNúmeros -> ListaDeNúmeros
;; Adiciona n ao final de ldn.
(examples
  (check-equal? (cons-fim 3 empty) (cons 3 empty))
  (check-equal? (cons-fim 1 (cons 3 (cons 4 empty)))
                (cons 3 (cons 4 (cons 1 empty)))))
(define (cons-fim n ldn)
  (cond
    [(empty? ldn) (cons n empty)]
    [else
     (cons (first ldn)
           (cons-fim n (rest ldn)))]))
```



Inteiros
========


## Definição

Às vezes queremos utilizar um caso base diferente de $0$. \pause

Podemos generalizar a definição de número natural para incluir um limite inferior diferente de $0$.


## Definição Inteiro

Um número **Inteiro>=a** é

- $a$; ou

- `(add1 n)` onde $n$ é um número **Inteiro>=a**

\pause

Modelo

```scheme
(define (fn-para-inteiro>=a n)
  (cond
    [(<= n a) ...]
    [else
      (... n
           (fn-para-inteiro>=a (sub1 n)))]))
```



Árvores binárias
================


## Árvores binárias

Como podemos definir uma árvore binária?

```
        3
      /   \
     4     7
    /     / \
   3     8   9
            /
           10
```


## Árvores binárias

Uma **ÁrvoreBináriaDeNúmeros** é \pause

- `empty`; ou

- `(no Número ÁrvoreBináriaDeNúmeros ÁrvoreBináriaDeNúmeros)`, onde `no` é uma estrutura com os campos `valor`, `esq` e `dir`

\pause

Modelo

```scheme
(define (fn-para-abdn t)
  (cond
    [(empty? t) ...]
    [else
      (... (no-valor t)
           (fn-para-abdn (no-esq t))
           (fn-para-abdn (no-dir t)))]))
```


## Exemplo: altura árvore

Defina uma função que calcule a altura de uma árvore binária. A altura de uma árvore binária é a distância entre a raiz e o seu descendente mais afastado. Uma árvore com um único nó tem altura 0.


## Exemplo: altura árvore

\scriptsize

```scheme
;;     t4  3
;;       /   \
;;  t3  4     7  t2
;;     /     / \
;;    3     8   9  t1
;;             /
;;        t0  10
;; ÁrvoreBináriaDeNúmeros -> Natural
(check-equal? (altura empty) ?)
(check-equal? (altura t0) 0)
(check-equal? (altura t1) 1)
(check-equal? (altura t2) 2)
(check-equal? (altura t3) 1)
(check-equal? (altura t4) 3)
(define (altura t)
  (cond
    [(empty? t) ...]
    [else (... (no-valor t)
               (altura (no-esq t))
               (altura (no-dir t)))]))
```


## Exemplo: altura árvore

\scriptsize

```scheme
;;     t4  3
;;       /   \
;;  t3  4     7  t2
;;     /     / \
;;    3     8   9  t1
;;             /
;;        t0  10
;; ÁrvoreBináriaDeNúmeros -> Natural
(check-equal? (altura empty) -1)
(check-equal? (altura t0) 0)
(check-equal? (altura t1) 1)
(check-equal? (altura t2) 2)
(check-equal? (altura t3) 1)
(check-equal? (altura t4) 3)
(define (altura t)
  (cond
    [(empty? t) -1]
    [else (add1 (max
                 (altura (no-esq t))
                 (altura (no-dir t))))]))
```



Listas aninhadas
================


## Listas aninhadas

Às vezes é necessário criar uma lista, que contenha outras listas, e estas listas contenham outras listas, etc. \pause

```scheme
> (list 1 4 (list 5 empty (list 2) 9) 10)
'(1 4 (5 () (2) 9) 10)
```

\pause

Chamamos este tipo de lista de lista aninhada. \pause Como podemos definir uma lista aninhada?


## Listas aninhadas

Uma **ListaAninhadaDeNúmeros** é

- `empty`; ou

- `(cons ListaAninhadaDeNúmeros ListaAninhadaDeNúmeros)`

- `(cons Número ListaAninhadaDeNúmeros)`


## Listas aninhadas

```scheme
;; Modelo
#;
(define (fn-para-ladn ldn)
  (cond
    [(empty? ldn) ...]
    [(list? (first ldn))
     (... (fn-para-ladn (first ldn))
          (fn-para-ladn (rest ldn)))]
    [else
     (... (first ldn)
          (fn-para-ladn (rest ldn)))]))
```


## Exemplo: soma*

Defina uma função que some todos os números de uma lista aninhada de números.


## Exemplo: soma*

\scriptsize

```scheme
;; ListaAninhadaDeNúmeros -> Número
;; Devolve a soma de todos os elementos de ldn.
(examples
 (check-equal? (soma* empty)
               0)
 (check-equal? (soma* (list (list 1 (list empty 3)) (list 4 5) 4 6 7))
               30))
(define (soma* ldn)
  (cond
    [(empty? ldn) ...]
    [(list? (first ldn))
     (... (soma* (first ldn))
          (soma* (rest ldn)))]
    [else
     (... (first ldn)
          (soma* (rest ldn)))]))
```


## Exemplo: soma*

\scriptsize

```scheme
;; ListaAninhadaDeNúmeros -> Número
;; Devolve a soma de todos os elementos de ldn.
(examples
 (check-equal? (soma* empty)
               0)
 (check-equal? (soma* (list (list 1 (list empty 3)) (list 4 5) 4 6 7))
               30))
(define (soma* ldn)
  (cond
    [(empty? ldn) 0]
    [(list? (first ldn))
     (+ (soma* (first ldn))
        (soma* (rest ldn)))]
    [else
     (+ (first ldn)
        (soma* (rest ldn)))]))
```


## Exemplo: aplaina

Defina uma função que aplaine uma lista aninhada, isto é, transforme uma lista aninhada em uma lista sem listas aninhadas com os mesmos elementos e na mesma ordem da lista aninhada.


## Exemplo: aplaina

\scriptsize

```scheme
;; ListaAninhadaDeNúmeros -> ListaDeNúmeros
;; Devolve uma versão não aninhada de ldn, isto é, uma lista com os mesmos
;; elementos de ldn, mas sem aninhamento.
(examples
 (check-equal? (aplaina empty) empty)
 (check-equal? (aplaina (list (list 1 (list empty 3)) (list 4 5) 4 6 7))
               (list 1 3 4 5 4 6 7)))
(define (aplaina ldn)
  (cond
    [(empty? ldn) ...]
    [(list? (first ldn))
     (... (aplaina (first ldn))
          (aplaina (rest ldn)))]
    [else
     (... (first ldn)
          (aplaina (rest ldn)))]))
```


## Exemplo: aplaina

\scriptsize

```scheme
;; ListaAninhadaDeNúmeros -> ListaDeNúmeros
;; Devolve uma versão não aninhada de ldn, isto é, uma lista com os mesmos
;; elementos de ldn, mas sem aninhamento.
(examples
 (check-equal? (aplaina empty) empty)
 (check-equal? (aplaina (list (list 1 (list empty 3)) (list 4 5) 4 6 7))
               (list 1 3 4 5 4 6 7)))
(define (aplaina ldn)
  (cond
    [(empty? ldn) empty]
    [(list? (first ldn))
     (append (aplaina (first ldn))
             (aplaina (rest ldn)))]
    [else
     (cons (first ldn)
           (aplaina (rest ldn)))]))
```



Observações finais
==================


## Observações finais

Usamos dados com autorreferências quando queremos representar dados de tamanhos arbitrários. \pause

- Usamos funções recursivas para processar dados com autorreferências. \pause

Para ser bem formada, uma definição com autorreferência deve ter: \pause

- Pelo menos um caso base (sem autorreferência): \pause são utilizados para criar os valores iniciais \pause

- Pelo menos um caso com autorreferência: \pause são utilizados para criar novos valores a partir de valores existentes \pause

As vezes é interessante pensar em números inteiros e naturais como sendo compostos e definidos com autorreferência.



Referências
===========

## Referências

<div class="columns">
<div class="column" width="48%">
Básicas

- [Vídeos Self-Reference](https://www.youtube.com/watch?v=tp44seRHLUQ&list=PL6NenTZG6KrptkOEMyLWDnF0ZjSpVTHAE)

- [Vídeos Naturals](https://www.youtube.com/playlist?list=PL6NenTZG6KroGNU9XgT5G5Dt2M6YGjZMF)

- Capítulos [8 a 12](https://htdp.org/2019-02-24/part_two.html) do livro
  [HTDP](http://htdp.org)

- Seções
    [2.3](http://docs.racket-lang.org/guide/Lists__Iteration__and_Recursion.html),
    [2.4](http://docs.racket-lang.org/guide/Pairs__Lists__and_Racket_Syntax.html) e
    [3.8](http://docs.racket-lang.org/guide/pairs.html) do
    [Guia Racket](http://docs.racket-lang.org/guide/)

</div>
<div class="column" width="48%">
Complementares

- Seções [2.1](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-14.html#%_sec_2.1) (2.1.1 - 2.1.3) e [2.2](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-15.html#%_sec_2.2) (2.2.1) do livro [SICP](https://mitpress.mit.edu/sicp/)

- Seções [3.9](http://docs.racket-lang.org/reference/pairs.html) da [Referência Racket](http://docs.racket-lang.org/reference/)

- Seção [6.3](http://www.scheme.com/tspl4/objects.html#./objects:h3) do livro [TSPL4](http://www.scheme.com/tspl4/)

- Capítulo [9.3](https://htdp.org/2018-01-06/Book/part_two.html#%28part._sec~3anats%29) do livro [HTDP](http://htdp.org)
</div>
</div>
