---
# vim: set spell spelllang=pt_br sw=4:
title: |
       | Programação Funcional
       | Autorreferência e recursividade - Parte II
urlcolor: Blue
license:
---

# Começando

@) Quando devemos ver um número natural como um dado composto?

@) Qual é o modelo de função associado com a definição do tipo natural?

@) O que é recursão estrutural?

@) Quando não podemos utilizar recursão estrutural para resolver um problema?

@) O que é recursão generativa?


# Praticando

<!-- Plano -->

@) Projete uma função que calcule a amplitude dos valores de uma lista não vazia de números, isto é, a diferença entre o valor máximo e mínimo da lista. Dica: crie um plano e use funções auxiliares.

@) Projete uma função que determine o tamanho médio das strings de uma lista. Dica: crie um plano e use funções auxilares.

@) Projete uma função que indique se em uma lista de inteiros existem mais valores positivos ou negativos. Dica: crie um plano e use funções auxiliares.


<!-- Números naturais -->

@) Projete uma função que receba como parâmetro um número natural $n$ e um valor $v$ e crie uma nova lista com $n$ repetições do valor $v$.

@) Projete uma função que receba como entrada um número $a$ (diferente de 0) e um número natural $n$ e calcule o valor $a^n$.

@) Projete uma função que receba como parâmetro um número natural $n$ e calcule o produto dos números $1, 2, \cdots, n$.

@) Recursão indireta é quando duas ou mais funções chamam uma a outra. Defina duas funções `impar?` e `par?`, uma em termos da outra, isto é, a função `impar?` deve chamar a função `par?` e a função `par?` deve chama a função `impar?` (a recursão para no caso base).


<!-- Árvores -->

@) Projete uma função que receba como entrada uma árvore binária `t` e um número `n` e devolva uma nova árvore binária que é como `t` mas com `n` somado a cada elemento.

@) Projete uma função que verifique se uma árvore binária é uma árvore binária de busca. Uma árvore binária de busca tem as seguintes propriedades: 1) A subárvore a esquerda contém valores nos nós menores que o valor no nó raiz. 2) A subárvore a direita contém valores nos nós maiores que o valor no nó raiz. 3) As subárvores a esquerda e a direita também são árvores binárias de busca.

@) Projete uma função que verifique se um elemento está em uma árvore binária de busca.

@) Projete uma função que receba como entrada uma lista aninhada `lst` e devolva uma nova lista aninhada como os mesmo elementos de `lst`, mas em ordem reversa.

    ```scheme
    > (reverse* (list (list 2 3) 8 (list 9 (list 10 11) 50) (list 10) 70))
    '(70 (10) (50 (11 10) 9) 8 (3 2))
    ```


<!-- Desafio - processamento simultâneo -->

@) (Desafio) Utilizando apenas as funções primitivas `zero?`, `add1` e `sub1`, escreva as funções `+`, `-` e `*`. Cada função deve receber como parâmetro dois números naturais e executar a operação aritmética apropriada.


# Resolvendo problemas

<!-- Funções auxiliares - plano -->

@) A Láurea Acadêmica é uma homenagem prestada a alunos que tiveram elevado nível de aproveitamento no curso de graduação. Na UEM, todos os alunos que tiveram mais do que 2/3 das notas finais das disciplinas maiores do que 9,0 recebem esta homenagem. Projete um programa que receba as notas finais de um aluno e determine se ele receberá a Láurea Acadêmica. Dica: faça um plano.

@) Uma eleição é realizada com apenas dois candidatos. Cada eleitor pode votar ou no primeiro candidato, ou no segundo candidato, ou ainda, votar em branco. O candidato que tiver mais votos ganha a eleição. Se os votos em branco forem mais do que 50% do total de votos, novas eleições devem ser convocadas. Projete uma função que receba como entrada uma lista não vazia de votos e determine qual foi o resultado da eleição. Dica: faça um plano.

@) O problema do menor retângulo delimitador consiste em determinar o retângulo de menor altura e menor largura que pode cobrir um conjunto de pontos no plano cartesiano. Projete uma função que resolva o problema do menor retângulo delimitador. Considere que o retângulo deve ter os lados paralelos aos eixos $x$ e $y$. Dica: faça alguns exemplos no papel e defina um plano.
