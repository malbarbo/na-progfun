---
# vim: set spell spelllang=pt_br sw=4:
title: |
       | Programação Funcional
       | Recursão estrutural: limitações e alternativas
urlcolor: Blue
license:
# TODO: adicionar desafios
---

# Começando

@) Dê um exemplo de problema, diferente dos vistos em sala, que não pode ser resolvido diretamente com recursão estrutural. Explique por que a solução do subproblema estrutural não ajuda a construir a solução do problema original.

@) Quais estratégias podemos utilizar quando a recursão estrutural não resolve o problema diretamente? Dê um exemplo de problema para cada estratégia.

@) Qual é a diferença entre recursão estrutural e recursão generativa?


# Praticando

<!-- Redefinição do problema -->

@) Um número natural $n$ é perfeito se ele é igual à soma dos seus divisores positivos menores que $n$. Por exemplo, $6$ é perfeito porque $6 = 1 + 2 + 3$. Projete uma função que verifique se um número natural é perfeito. Dica: redefina o problema, como fizemos para o número primo.

<!-- Plano -->

@) Projete uma função que calcule a amplitude dos valores de uma lista de números, isto é, a diferença entre o valor máximo e mínimo da lista. Dica: crie um plano e use funções auxiliares.

@) Projete uma função que determine o tamanho médio das strings de uma lista. Dica: crie um plano e use funções auxilares.

@) Projete uma função que indique se em uma lista de inteiros existem mais valores positivos ou negativos. Dica: crie um plano e use funções auxiliares.


# Resolvendo problemas

<!-- Funções auxiliares - plano -->

@) A Láurea Acadêmica é uma homenagem prestada a alunos que tiveram elevado nível de aproveitamento no curso de graduação. Na UEM, todos os alunos que tiveram mais do que 2/3 das notas finais das disciplinas maiores do que 9,0 recebem esta homenagem. Projete um programa que receba as notas finais de um aluno e determine se ele receberá a Láurea Acadêmica. Dica: faça um plano.

@) Uma eleição é realizada com apenas dois candidatos. Cada eleitor pode votar ou no primeiro candidato, ou no segundo candidato, ou ainda, votar em branco. O candidato que tiver mais votos ganha a eleição. Se os votos em branco forem mais do que 50% do total de votos, novas eleições devem ser convocadas. Projete uma função que receba como entrada uma lista não vazia de votos e determine qual foi o resultado da eleição. Dica: faça um plano.

@) O problema do menor retângulo delimitador consiste em determinar o retângulo de menor altura e menor largura que pode cobrir um conjunto de pontos no plano cartesiano. Projete uma função que resolva o problema do menor retângulo delimitador. Considere que o retângulo deve ter os lados paralelos aos eixos $x$ e $y$. Dica: faça alguns exemplos no papel e defina um plano.
