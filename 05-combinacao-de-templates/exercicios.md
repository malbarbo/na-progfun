---
title: Combinação de templates
num: 5
template: exercicios.tex
---

#.  Utilizando apenas as funções primitivas `zero?`, `add1` e `sub1`, escreva
    as funções `>`, `>=`, `<`, `<=` e `=`. Cada função deve receber como
    parâmetro dois números naturais e executar a operação de comparação
    apropriada.

#.  [pp99 1.02] Defina uma função que encontre o $k$-ésimo elemento de uma
    lista.

    ```racket
    > (list-ref (list 10 40 70 20) 2)
    70
    ```

#.  Defina uma função que devolve os $n$ primeiros elementos de uma lista.

    ```racket
    > (take (list 10 40 70 20 3) 2)
    '(10 40)
    ```

#.  Defina uma função que devolve um nova lista sem os $n$ primeiros elementos
    de uma dada lista.

    ```racket
    > (drop (list 10 40 70 20 3) 2)
    '(70 20 3)
    ```

#.  Defina uma função que devolva uma nova lista que é como a lista de entrada
    mas sem o elemento de uma dada posição.

    ```racket
    > (remove-at (list 3 6 1 2) 2)
    '(3 6 2)
    ```

#.  Defina uma função que devolva uma lista que é como a lista de entrada mas
    com um dado elemento inserido em uma dada posição.

    ```racket
    > (insert-at (list 3 6 1 2) 5 2)
    '(3 6 5 1 2)
    ```

#.  [pp99 1.18] Defina uma função que devolva uma sub-lista de uma lista com um
    intervalo especificado.

    ```racket
    > (sub-list (list 10 20 30 40 50) 1 4)
    '(20 30 40)
    ```

#.  [pp99 1.16] Defina uma função que devolva uma nova lista que é como a lista
    de entrada mas com os elementos rotacionados $n$ posições a esquerda.

    ```racket
    > (rotate-left (list 10 20 30 40 50) 2)
    '(30 40 50 10 20)
    ```

# Referências

-   [pp99]. [99 problemas para resolver em (Prolog) Racket](https://sites.google.com/site/prologsite/prolog-problems)

<!-- vim: set spell spelllang=pt_br: !-->
