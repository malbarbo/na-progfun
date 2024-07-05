---
# vim: set spell spelllang=pt_br sw=4:
title: Recursão generativa - Prática
urlcolor: Blue
---

@. Projete uma função que encontre o máximo de uma lista não vazia de números usando a seguinte estratégia: se a lista tem apenas um elemento, então ele é o máximo, senão, **gere** duas listas dividindo a lista de entrada na "metade" usando as funções [`take`](https://docs.racket-lang.org/reference/pairs.html#%28def.\_%28%28lib.\_racket%2Flist..rkt%29.\_take%29%29) e [`drop`](https://docs.racket-lang.org/reference/pairs.html#%28def.\_%28%28lib.\_racket%2Flist..rkt%29.\_drop%29%29), encontre o máximo de cada metade recursivamente e depois determine o máximo entre os dois resultados das chamadas recursivas. Por exemplo, dividindo a lista 4, 1, 3, 2, 7, 3 na metade obtemos as listas 4, 1, 3 e 2, 7, 3, o máximo da primeira lista (determinado recursivamente) é 4, o máximo da segunda lista (determinado recursivamente é 7), o máximo entre 4 e 7 é 7, portanto o máximo da lista é 7.

@. Projete uma função que converta um número natural para string usando a seguinte estratégia: se o número é menor que 10, converta o número diretamente para uma string (usando um `cond`{.scheme} com 10 casos!), senão **gere** dois números separando o último dígito do número (usando `(remainder n 10)`{.scheme}) dos demais dígitos (usando `(quotient n 10)`{.scheme}), converta recursivamente os dois números para string e junte as strings resultantes. Por exemplo, separando 451 obtemos 1 e 45, convertendo para strings (recursivamente) obtermos `"1"`{.scheme} e `"45"`{.scheme}, juntando as strings obtemos `"451"`{.scheme}.

#. Projete uma função que inverta os caracteres de uma string usando a seguinte estratégia: se a string é vazia ou se só tem um caractere, então a string invertida é a mesma, senão **gere** uma nova string removendo o primeiro e o último caractere da string ([`substring`](https://docs.racket-lang.org/reference/strings.html#%28def.\_%28%28quote.\_~23~25kernel%29.\_substring%29%29)), inverta essa string recursivamente e junte com o primeiro (no final) e com o último (no início). Por exemplo, removendo o primeiro e o último da string `"roma"`{.scheme} obtemos `"om"`{.scheme} que invertida é `"mo"`{.scheme}, junto com o o primeiro e o últimos obtemos `"amor"`{.scheme}.

<!--
@. Escreva uma função que conte de quantas formas diferentes podemos dar um valor de troco a partir de uma lista de valores de moedas. Por exemplo, existem 3 formas de dar o troco para o valor 4 se você tiver moedas de 1 e 2: $1 + 1 + 1 + 1$, $1 + 1 + 2$, $2 + 2$.
-->
