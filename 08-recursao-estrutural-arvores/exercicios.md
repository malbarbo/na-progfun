---
# vim: set spell spelllang=pt_br sw=4:
title: |
       | Programação Funcional
       | Recursão estrutural: árvores
urlcolor: Blue
license:
# TODO: exercício para projetar tipo com autorreferência
# TODO: adicionar problemas
---

# Começando

@) Explique por que o modelo de função para árvores binárias tem duas chamadas recursivas e o modelo de função para listas tem apenas uma.

@) Dê um exemplo de tipo de dado com autorreferência indireta diferente do sistema de arquivos e escreva os modelos de funções para processá-lo.


# Praticando

<!-- Árvores binárias -->

@) Projete uma função que determine quantos nós em uma árvore binária tem grau 2.

@) Uma árvore binária cheia é aquela em que todos os seus nós tem grau 0 ou 2. Projete uma função que determine se uma árvore binária é cheia.

@) Uma árvore binária balanceada é aquela em que a altura das subárvores a direita e a esquerda diferem em no máximo 1 e as duas subárvores também são balanceadas. Projete uma função que verifique se uma árvore binária é balanceada.

@) Projete uma função que verifique se uma árvore binária é uma árvore binária de busca. Uma árvore binária de busca tem as seguintes propriedades: 1) A subárvore a esquerda contém valores nos nós menores que o valor no nó raiz. 2) A subárvore a direita contém valores nos nós maiores que o valor no nó raiz. 3) As subárvores a esquerda e a direita também são árvores binárias de busca.

@) Projete uma função que verifique se um elemento está em uma árvore binária de busca.


<!-- Árvores -->

@) Modifique a representação do tipo para entrada em sistema de arquivos para que cada arquivo também tenha o seu tamanho (quantidade de bytes), em seguida:

    a) Projete uma função para calcular o número total de bytes ocupados por todos os arquivos a partir de uma entrada.
    a) Projete uma função para encontrar o maior arquivo a partir de um entrada.


# Desafios

@) Projete uma função para construir uma representação textual (lista de strings) de uma entrada em um sistema de arquivos. Exemplo

    ```
    disciplinas/
    +- 12026/
    |  +- alunos.txt
    |  +- trabs/
    |     +- trab1.md
    |     +- correcoes/
    |     |  +- rascunho.txt
    |     |  +- final.txt
    |     +- trab2.md
    +- 6879/
    +- 6884/
    +- anotacoes.txt
    ```
