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

De qualquer forma, vários elementos do processo de projeto também são revelantes para funções generativas. \pause

Vamos ver a seguir o projeto de algumas funções que usam recursão generativa.


Projeto de funções generativas
==============================

## Exemplo: quicksort

Defina uma função que ordene uma lista de números distintos usando o algoritmo de ordenação _quicksort_. \pause

Qual é a ideia do _quicksort_? \pause

- Selecionar um elemento da entrada como pivô. \pause

- Separar os elementos menores que o pivô e ordená-los recursivamente. \pause

- Separar os elementos maiores que o pivô e ordená-los recursivamente. \pause

- Juntar a ordenação dos menores, com o pivô e com os maiores.


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



## Referências

Básicas

- [Parte 5](https://htdp.org/2023-8-14/Book/part_five.html) do livro [HTDP](https://htdp.org/).
