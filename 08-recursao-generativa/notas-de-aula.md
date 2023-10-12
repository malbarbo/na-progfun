---
# vim: set spell spelllang=pt_br sw=4:
title: Recusão generativa
---

Introdução
==========

## Introdução

Vimos anteriormente como explorar a forma como um dado com autorreferência é definido para implementar funções que processam esse tipo de dado: \pause

- Uma autorreferência na definição do tipo do dado sugere uma chamada recursiva na implementação da função \pause

Como nesses casos a chamada recursiva é feita em uma parte da estrutura do dado a recursão é chamada de **recursão estrutural**.


## Introdução

Também vimos anteriormente que a recursão estrutural tem limitações e nem todos os problemas podem ser resolvidos com ela. \pause

Discutimos rapidamente que para esses problemas precisamos utilizar outra abordagem: \pause

- Decompor o problema inicial em subproblemas
- Resolver os subproblemas
- Combinar as soluções dos subproblemas em uma solução para o problema inicial\pause

Se alguns dos subproblemas gerados são do mesmo tipo do problema inicial, podemos usar chamadas recursivas para resolver esses subproblemas, nesses casos, a recursão é chamada de **recursão generativa**.


## Introdução

A recursão generativa é mais poderosa que a recursão estrutural, \pause porém, \pause projetar funções que usam recursão generativa não é um processo tão direto quando funções que usam recursão estrutural. \pause A etapa principal é "gerar" os subproblemas, e isto pode requerer um momento "eureka". \pause

De qualquer forma, o processo de projeto de funções, com alguns ajustes, também serve para projetar funções com recursão generativa. \pause

Vamos ver alguns exemplos.



Projeto de funções generativas
==============================


## Exemplo: agrupamento

Dado uma lista de números e um número positivo $n$, projete uma função que agrupe os elementos da lista de entrada em grupos (listas) de $n$ elementos.


## Exemplo: agrupamento

\small

```scheme
;; (Lista Número) InteiroPositivo -> (Lista (Lista Número))
;;
;; Agrupa os elementos de lst em listas
;; com n elementos. Apenas a última lista
;; do resultado pode ficar com menos que n
;; elementos.
(examples
 (check-equal? (agrupa empty 2) empty)
 (check-equal? (agrupa (list 4 1 5) 1)
               (list (list 4) (list 1) (list 5)))
 (check-equal? (agrupa (list 4 1 5 7 8) 2)
               (list (list 4 1) (list 5 7) (list 8)))
 (check-equal? (agrupa (list 4 1 5 7 8) 3)
               (list (list 4 1 5) (list 7 8))))
```


## Exemplo: agrupamento

\small

```scheme
(define (agrupa lst n)
  (cond
    [(empty? lst) empty]
    [(< (length lst) n) (list lst)]
    [else
     (cons (take lst n)
           (agrupa (drop lst n) n))]))
```


## Exemplo: quicksort

Defina uma função que ordene uma lista de números distintos usando o algoritmo de ordenação _quicksort_. \pause

Qual é a ideia do _quicksort_? \pause

- Separar os elementos da entrada (não trivial) em duas listas: uma com os menores do que o primeiro e outra com os maiores do que o primeiro \pause

- Ordenar as duas listas recursivamente \pause

- Juntar a ordenação dos menores, com o primeiro e com a ordenação dos maiores.


## Exemplo: quicksort

\small

```scheme
;; Lista(Número) -> Lista(Número)
;; Ordena lst em ordem não decrescente usado o quicksort.
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

\small

```scheme
(define (quicksort lst)
  (cond
    [(empty? lst) empty]
    [else
     (define pivo (first lst))
     (append (quicksort (filter (curry > pivo) lst))
             (list pivo)
             (quicksort (filter (curry < pivo) lst)))]))
```

\pause

\normalsize

O que acontece se a lista tiver elementos repetidos? \pause A função para não terminar! \pause

Isso porque a chamada recursiva poderá ser feita para a mesma lista de entrada.


## Processo de projeto

O que precisamos ajustar no processo de projeto de funções? \pause

Na etapa de implementação temos que: \pause

- Determinar se o problema pode ser resolvido diretamente \pause

- Determinar como resolver o problema diretamente \pause

- Definir como decompor o problema em subproblemas que são mais facilmente resolvidos do que o problema original \pause

- Definir combinar as soluções dos subproblemas para resolver o problema inicial \pause

- Argumentar que a função termina para todas as entradas


## Referências

Básicas

- [Parte 5](https://htdp.org/2023-8-14/Book/part_five.html) do livro [HTDP](https://htdp.org/).
