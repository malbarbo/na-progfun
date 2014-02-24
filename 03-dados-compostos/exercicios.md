---
title: Dados compostos
num: 3
template: exercicios.tex
---

#.  Defina uma função que verifique se um determinado elemento está em uma
    lista.

#.  Defina uma função que receba com entrada uma lista `lst` e um elemento `a`
    e devolva uma lista que é como `lst` mas sem as ocorrências de `a`.

    ```racket
    > (remove-todos (list 3 2 3 5 8 3) 3)
    '(2 5 8)
    ```

#.  Defina uma função que receba como entrada uma lista `lst` e um elemento `a`
    e devolva uma lista que é como `lst` mas com `a` no final.

    ```racket
    > (cons-fim (list 5 2 8) 3)
    '(5 2 8 3)
    ```

#.  Defina uma função que que rebeba como entrada uma lista `lst` e devolva uma
    lista com os mesmos elementos de `lst` mas em ordem reversa. Dica: use
    a função `cons-fim`.

    ```racket
    > (inverte (list 1 2 3 4 5))
    '(5 4 3 2 1)
    ```
#.  Defina uma função que determine se uma lista é palíndromo. Dica: use
    a função `inverte`.

#.  Defina uma função que receba como entrada uma lista `lst` de números e um
    número `n` e devolva uma lista com cada elemento de `lst` somado com `n`.

    ```racket
    > (lista-add-num (list 2 6 1 4 10) 3)
    '(5 9 4 7 13)
    ```

#.  Defina uma função que receba como entrada uma lista `lst` de número
    naturais e devolva uma lista que é como `lst` mas sem números pares.

#.  Defina uma função que devolva o último elemento de uma lista. Use a função
    `error` (com uma string de mensagem como argumento) para indicar erro se
    a lista for vazia.

#.  Defina uma função que encontre o valor máximo de uma lista de números.

#.  Defina uma função que receba como entrada uma lista `lst` de números em
    ordem crescente e um número `n` e devolva uma lista com os elementos de
    `lst` e com `n` em ordem crescente.

    ```racket
    > (insere-ordenado (list 2 8 10) 5)
    '(2 5 8 10)
    ```

#.  Defina uma função que receba como entrada uma lista de números e devolva
    uma lista como os mesmos valores de entrada mas em ordem crescente.
    (Lembre-se de aplicar a receita de projeto, não tente implementar um método
    de ordenação qualquer, a receita te levará a implementar um método
    específico). Dica: use a função `insere-ordenado`.

#.  Continua ...
