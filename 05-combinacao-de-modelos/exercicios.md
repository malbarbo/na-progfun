---
# vim: set spell spelllang=pt_br sw=4:
title: Combinação de templates
---

#.  Utilizando apenas as funções primitivas `zero?`, `add1` e `sub1`, escreva
    as funções `>`, `>=`, `<`, `<=` e `=`. Cada função deve receber como
    parâmetro dois números naturais e executar a operação de comparação
    apropriada.

#.  Defina uma função que devolve os $n$ primeiros elementos de uma lista.

    ```scheme
    > (take (list 10 40 70 20 3) 2)
    '(10 40)
    ```

#.  Defina uma função que devolve um nova lista sem os $n$ primeiros elementos
    de uma dada lista.

    ```scheme
    > (drop (list 10 40 70 20 3) 2)
    '(70 20 3)
    ```

#.  Defina uma função que devolva uma nova lista que é como a lista de entrada
    mas sem o elemento de uma dada posição.

    ```scheme
    > (remove-at (list 3 6 1 2) 2)
    '(3 6 2)
    ```

#.  Defina uma função que devolva uma lista que é como a lista de entrada mas
    com um dado elemento inserido em uma dada posição.

    ```scheme
    > (insert-at (list 3 6 1 2) 5 2)
    '(3 6 5 1 2)
    ```

#.  [pp99 1.18] Defina uma função que devolva uma sub-lista de uma lista com um
    intervalo especificado.

    ```scheme
    > (sub-list (list 10 20 30 40 50) 1 4)
    '(20 30 40)
    ```

#.  [pp99 1.16] Defina uma função que devolva uma nova lista que é como a lista
    de entrada mas com os elementos rotacionados $n$ posições a esquerda.

    ```scheme
    > (rotate-left (list 10 20 30 40 50) 2)
    '(30 40 50 10 20)
    ```

#.  Dado duas listas de entrada, `lsta` e `lstb`, defina uma função que devolva
    uma nova lista com os elementos de `lsta` seguidos dos elementos de `lstb`.

    ```scheme
    > (append (list 3 7 12) (list 2 4 5))
    '(3 7 12 2 4 5)
    ```

#.  Dado duas listas de números em ordem crescente, defina uma função que
    devolva uma nova lista com os elementos das duas listas de entrada em ordem
    crescente.

    ```scheme
    > (merge (list 3 7 12) (list 2 4 5))
    '(2 3 4 5 7 12)
    ```

#.  Escreva uma função que conte de quantas formas diferentes podemos dar um
    valor de troco a partir de uma lista de valores de moedas. Por exemplo,
    existem 3 formas de dar o troco para o valor 4 se você tiver moedas de
    1 e 2: 1+1+1+1, 1+1+2, 2+2.


# Referências

-   [pp99]. [99 problemas para resolver em (Prolog) Racket](https://sites.google.com/site/prologsite/prolog-problems)
