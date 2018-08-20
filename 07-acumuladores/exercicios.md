---
title: Acumuladores
num: "7"
template: exercicios.tex
---

#.  Analise os exemplos e exercícios de dados compostos e funções e redefina as
    funções (que se beneficiarem) para utilizar acumuladores. Descreva
    o benefício e o propósito do acumulador. Utilize a função `foldl` onde for
    apropriado.

#.  Analise os exemplos e exercícios de números naturais e defina uma função
    `reduz-num-acc` (semelhante a função `reduz-acc` feita em sala) que
    abstraia o comportamento do template para funções com números naturais
    utilizando acumuladores. Redefina as funções (que se beneficiarem) em
    termos de `reduz-num-acc`.

#.  Defina uma função que verifique o balanceamento dos parênteses em uma expressão.
    Não se preocupe com a corretude da expressão. Utilize a função `string->list`
    para converter a string de entrada em uma lista.

    ```racket
    > (balanceada "2+(3*(4/2-1))*(2+3*(5/2))")
    true
    ```

<!-- vim: set spell spelllang=pt_br: !-->
