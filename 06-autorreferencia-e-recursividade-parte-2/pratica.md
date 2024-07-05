---
# vim: set spell spelllang=pt_br sw=4:
title: Autorreferência e recursividade - Prática
urlcolor: Black
---

<!-- Números naturais -->

@. Projete uma função que receba como parâmetro um número natural $n$ e calcule o produto dos números $1, 2, \cdots, n$.

@. Projete uma função que receba como entrada um número $a$ (diferente de 0) e um número natural $n$ e calcule o valor $a^n$.

@. Projete uma função que receba como entrada dois números naturais maiores que zero, $n$ e $x$, e devolva uma lista com os divisores de $x$ que são menores ou iguais a $n$ (não se preocupe com a ordem dos valores na resposta).

@. Um número natural é perfeito se a soma dos seu divisores, exceto ele mesmo, é igual a ele. Por exemplo, o número $6$ é perfeito porque $6 = 1 + 2 + 3$. Projete uma função que use uma sequência de etapas para verificar se um número natural é perfeito.

@. Recursão indireta é quando duas ou mais funções chamam uma a outra. Defina duas funções `impar?` e `par?`, uma em termos da outra.


<!-- Árvores -->

@. Projete uma função que receba como entrada uma árvore binária `t` e um número `n` e devolva uma nova árvore binária que é como `t` mas com `n` somado a cada elemento.

@. Projete uma função que verifique se uma árvore binária é uma árvore binária de busca. Uma árvore binária de busca tem as seguintes propriedades: 1) A subárvore a esquerda contém valores nos nós menores que o valor no nó raiz. 2) A subárvore a direita contém valores nos nós maiores que o valor no nó raiz. 3) As subárvores a esquerda e a direita também são árvores binárias de busca.

@. Projete uma função que verifique se um elemento está em uma árvore binária de busca.

@. Projete uma função que receba como entrada uma lista aninhada `lst` e devolva uma nova lista aninhada como os mesmo elementos de `lst`, mas em ordem reversa.

    ```scheme
    > (reverse* (list (list 2 3) 8 (list 9 (list 10 11) 50) (list 10) 70))
    '(70 (10) (50 (11 10) 9) 8 (3 2))
    ```



<!-- Desafio - processamento simultâneo -->

@. (Desafio) Utilizando apenas as funções primitivas `zero?`, `add1` e `sub1`, escreva as funções `+`, `-` e `*`. Cada função deve receber como parâmetro dois números naturais e executar a operação aritmética apropriada.
