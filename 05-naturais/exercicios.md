---
# vim: set spell spelllang=pt_br sw=4:
title: Naturais
---

#.  Defina uma função que calcule o fatorial de um número.

#.  Utilizando apenas as funções primitivas `zero?`, `add1` e `sub1`, escreva
    as funções `+`, `-` e `*`. Cada função deve receber como parâmetro dois
    números naturais e executar a operação aritmética apropriada.

#.  [tspl 2.8.6] Recursão indireta é quando dois (ou mais) procedimentos usam
    um ao outro. Defina duas funções `impar?` e `par?`, uma em termos da outra.
    (Dica: O que cada uma deve retornar quando o argumento for $0$?)

#.  Defina uma função que determine se um dado número inteiro positivo
    é perfeito. Um número é perfeito se a soma dos seus divisores próprios
    é igual a ele. Por exemplo, o número $6$ é perfeito, pois $6 = 1 + 2 + 3$.
    O número $28$ também é perfeito, pois $28 = 1 + 2 + 4 + 7 + 14$.

#.  Defina uma função que conte quantos números primos existem em um dado
    intervalo.

#.  Defina uma função que calcule o elemento $e_{ij}$ do triângulo de Pascal,
    onde $i$ e $j$ são respectivamente a linha e coluna em que se encontra o
    elemento $e$. O triângulo de Pascal calculado até a 6ª linha:
    ```
    1
    1 1
    1 2  1
    1 3  3  1
    1 4  6  4 1
    1 5 10 10 5 1
    ```

# Referências

-   [tspl]. [The Scheme Programming Languague](http://www.scheme.com/tspl4/)
