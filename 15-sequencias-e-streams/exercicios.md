---
# vim: set spell spelllang=pt_br sw=4:
title: Sequências e streams
---

#.  Defina uma função `multiplos` que receba como parâmetro um inteiro
    positivo $n$ e devolva um stream com os múltiplos de $n$ maiores 0.

    ```scheme
    > (stream->list (stream-take (multiplos 5) 4))
    '(5 10 15 20)
    ```

#.  Defina uma função `primos` que produz um stream dos números primos. (Dica:
    use `stream-filter` e o predicado `primo?`)

    ```scheme
    > (stream->list (stream-take (primos) 5))
    '(2 3 5 7 11)
    ```

#.  [sicp 2.40] Defina uma função `unique-pairs` que, dado um inteiro $n$ gere
    a lista de pares $(i, j)$ com $1 \le j < i \le n$. Cada par é representado
    por uma lista com os dois elementos do par. (Dica: use list comprehension)

#.  [sicp 2.41] Escreva uma função que encontre todas as triplas ordenadas de
    inteiros positivos distintos $i, j$ e $k$ menores ou iguais a um dado
    inteiro $n$ cuja a soma seja igual a um dado inteiro $s$. (Dica: use list
    comprehension)


# Referências

-   [sicp]. [Structure and Interpretation of Computer Programs](https://mitpress.mit.edu/sicp/)
