---
# vim: set spell spelllang=pt_br sw=4:
title: |
       | Programação Funcional
       | Autorreferência e recursividade - Parte II
urlcolor: Blue
license:
# TODO: exercício para projetar tipo com autorreferência
# TODO: completar 5 problemas
---

# Começando

@) Quando devemos ver um número natural como um dado composto?

@) Qual é o modelo de função associado com a definição do tipo natural?

@) O que é recursão estrutural?

@) Quando não podemos utilizar recursão estrutural para resolver um problema?

@) Quais estratégias podemos utilizar quando a recursão estrutural não pode ser usada?

@) O que é recursão generativa?


# Praticando

<!-- Plano -->

@) Projete uma função que calcule a amplitude dos valores de uma lista de números, isto é, a diferença entre o valor máximo e mínimo da lista. Dica: crie um plano e use funções auxiliares.

@) Projete uma função que determine o tamanho médio das strings de uma lista. Dica: crie um plano e use funções auxilares.

@) Projete uma função que indique se em uma lista de inteiros existem mais valores positivos ou negativos. Dica: crie um plano e use funções auxiliares.


<!-- Números naturais -->

@) Projete uma função que receba como parâmetro um número natural $n$ e um valor $v$ e crie uma nova lista com $n$ repetições do valor $v$.

@) Projete uma função que receba como entrada um número $a$ e um número natural $n$ e calcule o valor $a^n$.

@) Projete uma função que receba como parâmetro um número natural $n$ e calcule o produto dos números $1, 2, \cdots, n$.

@) Recursão indireta é quando duas ou mais funções chamam uma a outra. Defina duas funções `impar` e `par`, uma em termos da outra, isto é, a função `impar` deve chamar a função `par` e a função `par` deve chama a função `impar` (a recursão para no caso base).


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


# Resolvendo problemas

<!-- Funções auxiliares - plano -->

@) A Láurea Acadêmica é uma homenagem prestada a alunos que tiveram elevado nível de aproveitamento no curso de graduação. Na UEM, todos os alunos que tiveram mais do que 2/3 das notas finais das disciplinas maiores do que 9,0 recebem esta homenagem. Projete um programa que receba as notas finais de um aluno e determine se ele receberá a Láurea Acadêmica. Dica: faça um plano.

@) Uma eleição é realizada com apenas dois candidatos. Cada eleitor pode votar ou no primeiro candidato, ou no segundo candidato, ou ainda, votar em branco. O candidato que tiver mais votos ganha a eleição. Se os votos em branco forem mais do que 50% do total de votos, novas eleições devem ser convocadas. Projete uma função que receba como entrada uma lista não vazia de votos e determine qual foi o resultado da eleição. Dica: faça um plano.

@) O problema do menor retângulo delimitador consiste em determinar o retângulo de menor altura e menor largura que pode cobrir um conjunto de pontos no plano cartesiano. Projete uma função que resolva o problema do menor retângulo delimitador. Considere que o retângulo deve ter os lados paralelos aos eixos $x$ e $y$. Dica: faça alguns exemplos no papel e defina um plano.

@) Em um determinado jogo de construção de itens, cada item tem uma classe que varia de 1 a 10. Os item de classe 1 surgem conforme o jogador explorar os baús. Um item de classe 2 ou superior precisa ser construídos unindo dois itens da classe anterior. Por exemplo, para construir um item de classe 2 é necessário unir dois item de classe 1. Para construir um item de classe 10 é necessário unir dois item de classe 9. Projete uma função que receba como entrada um número $n$ (de 1 a 10), e determine quantos itens de classe 1 são necessário para construir um item de classe $n$. Suponha que a únicas operações aritméticas disponíveis sejam a soma e a multiplicação.


# Desafios

@) Projeto uma função para construir uma representação textual (lista de strings) de uma entrada em um sistema de arquivos. Exemplo

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

@) Dados duas listas `lsta` e `lstb`, defina uma função que verifique se `lsta` é prefixo de `lstb`, isto é `lstb` começa com `lsta`.
