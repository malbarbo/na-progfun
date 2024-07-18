---
# vim: set spell spelllang=pt_br sw=4:
title: |
       | Programação Funcional
       | Autorreferência e recursividade - Parte I
urlcolor: Blue
license:
# TODO: adicionar mais exercícios de map e filter.
# TODO: adicionar exercícios de lista de estruturas.
---

# Começando

@) O que é um tipo de dado com autorreferência?

@) Quando uma definição com autorreferência está bem formada?

@) Quando utilizamos tipos de dados com autorreferência?

@) O que é uma função recursiva?

@) Qual é o modelo de função associado com a definição do tipo lista?


# Praticando

<!-- Básico - reduce -->

@) Projete uma função que concatene todas os elementos de uma lista de strings.

@) Projete uma função que determine a quantidade de elementos de uma lista de números. Dica: o primeiro elemento pode ser ignorado.


<!-- Básico - map -->

@) Projete uma função que crie uma lista de números a partir de uma lista de strings convertendo cada string para um número. Assuma que todas as strings representam números válidos.

<!-- Básico - filter -->

@) Projete uma função que crie uma nova lista removendo todas os valores nulos de uma lista de inteiros.

<!-- Processamento parcial -->

@) Projete uma função que verifique se todos os elementos de uma lista de booleanos são verdadeiro. Se a sua implementação inicial utilizar `if`{.scheme} para fazer a chamada recursiva, simplifique o código removendo o `if`{.scheme}.

<!-- Ajuste caso base -->

@) Projete uma função que determine o tamanho máximo entre todas as strings de uma lista não vazia de strings.

@) Projete uma função que verifique se uma lista de números está em ordem não decrescente. Dica: use dois casos base.

<!-- Funções auxiliares -->

@) Defina uma função que que receba como entrada uma lista `lst` e devolva uma lista com os mesmos elementos de `lst` mas em ordem contrária.

<!-- Desafio - processamento simultâneo -->

@) (Desafio) Dados duas listas `lsta` e `lstb`, defina uma função que verifique se `lsta` é prefixo de `lstb`, isto é `lstb` começa com `lsta`.


# Resolvendo problemas

@) Júlia tem uma pequena empresa de sorvetes que vende três sabores diferentes: manga, uva e morango. Cada sorvete é vendido por 10 reais, mas o custo de produção de cada sorvete depende do sabor: o de manga custa 6, o de uva 7 e o de morango 8. Toda vez que a Júlia vende um sorvete ela anota o sabor em uma lista. Após ter anotado os sabores dos sorvetes vendidos em uma lista, é hora de calcular quanto foi o ganho, e para isso a Júlia precisa da sua ajuda. Projete uma função que receba como entrada uma lista com os sabores dos sorvetes vendidos e calcule qual foi o ganho da Júlia vendendo os sorvetes.

@) O mestrando em física Alberto está tendo problemas com o equipamento que ele está usando para medir a temperatura de um material. O equipamento faz uma leitura a cada 10 segundos, mas ao invés de gerar apenas um número (temperatura), por vez, ele está gerando o mesmo número diversas vezes a cada leitura. Como o Alberto não tem verba para consertar o equipamento, ele está contando com a sua ajudar para fazer um programa que corrigi os dados lido pelo equipamento. Note que ele espera que cada leitura seja maior que a anterior, então se o equipamento ler os valores 3, 3, 7, 7, 7, 10 a leitura esta errada, o correto seria 3, 7, 10.

@) Você acaba de ser contratado por um empresa que está desenvolvendo um sistema de gerenciamento de campeonatos amadores de futebol. A sua primeira tarefa é projetar uma função que calcule o desempenho de um time, que consiste no número de pontos, número de vitórias e saldo de gols (diferenças entre os gols feitos e sofridos) de um time a partir dos resultados das partidas que ele jogou. Cada vitória gera três pontos e cada empate um ponto. Por exemplo, se os resultados para um determinado time foram $5 \times 1$, $0 \times 2$ e $1 \times 1$, onde o primeiro número são os gols feitos e o segundo os gols sofridos, então o time fez 4 pontos, obteve 1 vitória e saldo de gols de 2.

@) Uma dos problemas mais conhecidos de programação é o problema de ordenação. Existem diversos métodos já estabelecidos de ordenação, como a ordenação por seleção e intercalação. O uso do modelo para funções que processam listas leva a uma implementação específica. Projete uma função usando o modelo para listas que ordene uma lista de números. Dica: deseje por uma função auxiliar para combinar o primeiro elemento com o resultado da chamada recursiva. Como é conhecido esse método de ordenação?
