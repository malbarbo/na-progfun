---
# vim: set spell spelllang=pt_br sw=4:
title: |
       | Programação Funcional
       | Recursão estrutural: árvores
urlcolor: Blue
license:
---

Todas as funções projetadas nos exercícios devem ser totais.

# Começando

@) Explique por que o modelo de função para árvores binárias tem duas chamadas recursivas e o modelo de função para listas tem apenas uma.

@) Em uma empresa, cada funcionário tem um nome e uma lista de subordinados, que também são funcionários. Projete um tipo de dado para representar um funcionário e escreva os modelos de funções para processá-lo.


# Praticando

<!-- Árvores binárias -->

@) O grau de um nó é a quantidade de subárvores não vazias do nó. Projete uma função que determine quantos nós em uma árvore binária têm grau 2.

@) Uma árvore binária cheia é aquela em que todos os seus nós têm grau 0 ou 2. Projete uma função que determine se uma árvore binária é cheia.

@) Uma árvore binária balanceada é aquela em que a altura das subárvores à direita e à esquerda diferem em no máximo 1 e as duas subárvores também são balanceadas. Projete uma função que verifique se uma árvore binária é balanceada.

@) Projete uma função que verifique se uma árvore binária é uma árvore binária de busca. Uma árvore binária de busca tem as seguintes propriedades: 1) Todos os valores da subárvore à esquerda são menores que o valor da raiz. 2) Todos os valores da subárvore à direita são maiores que o valor da raiz. 3) As subárvores à esquerda e à direita também são árvores binárias de busca.

@) Projete uma função que verifique se um elemento está em uma árvore binária de busca.

@) Projete uma função que insira um elemento em uma árvore binária de busca. Se o elemento já estiver na árvore, a árvore deve ser devolvida sem alterações.

@) Projete uma função que produza uma lista com os valores de uma árvore binária em ordem: primeiro os valores da subárvore à esquerda, depois o valor da raiz e por fim os valores da subárvore à direita. O que você pode dizer sobre a lista produzida quando a árvore é uma árvore binária de busca?

@) Uma expressão aritmética é um número inteiro, uma soma de duas expressões ou uma multiplicação de duas expressões. Projete um tipo de dado para representar uma expressão aritmética e uma função que calcule o valor de uma expressão. Por exemplo, o valor da expressão $2 * (3 + 4)$ é 14.


<!-- Árvores -->

@) Projete uma função que encontre o caminho mais longo, em quantidade de caracteres, entre todas as entradas a partir de uma entrada. Os caminhos devem ser formados como no exemplo `encontra_txt` das notas de aula.

@) Modifique a representação do tipo para entrada em sistema de arquivos para que cada arquivo também tenha o seu tamanho (quantidade de bytes), em seguida:

    a) Projete uma função para calcular o número total de bytes ocupados por todos os arquivos a partir de uma entrada.
    a) Projete uma função para encontrar o maior arquivo a partir de uma entrada.


# Resolvendo problemas

@) Em um jogo de adivinhação, o jogador pensa em um animal e o computador tenta descobrir qual é fazendo perguntas de sim ou não. A pergunta seguinte depende da resposta anterior, até que o computador dê um palpite. Por exemplo:

    ```
    Ele voa?
    +- sim: Ele é noturno?
    |  +- sim: coruja
    |  +- não: pombo
    +- não: Ele vive na água?
       +- sim: peixe
       +- não: cachorro
    ```

    Para que o computador chegue em pombo, o jogador tem que responder sim e depois não. Para testar o jogo, os desenvolvedores querem saber, para um dado animal, quais respostas o jogador tem que dar para que o computador chegue a ele. Projete um tipo de dado para representar as perguntas e os palpites do jogo e uma função que determine as respostas que levam a um animal.

@) Uma loja fez uma promoção de indicação: cada cliente pode indicar novos clientes, que também podem indicar outros. No final da promoção, cada cliente ganha um desconto de 10 reais em uma compra para cada cliente que indicou e que comprou pelo menos 100 reais durante a promoção. Por exemplo, se Ana indicou Bia, que comprou 150 reais, e Caio, que comprou 80 reais, e Bia indicou Davi, que comprou 200 reais, então Ana ganha 10 reais de desconto, Bia ganha 10 reais, e Caio e Davi não ganham desconto. A loja quer saber o total de descontos que vai conceder, que nesse exemplo é 20 reais. Projete um tipo de dado para representar um cliente com as suas indicações e uma função que calcule o total de descontos concedidos a um cliente e a todos os clientes indicados por ele, direta ou indiretamente.


# Desafios

@) Projete uma função para construir uma representação textual (lista de strings) de uma entrada em um sistema de arquivos. Exemplo:

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
