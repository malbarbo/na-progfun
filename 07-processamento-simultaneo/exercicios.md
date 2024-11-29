---
# vim: set spell spelllang=pt_br sw=4:
title: |
       | Programação Funcional
       | Processamento simultâneo
urlcolor: Blue
license:
---

# Começando

@) Quando devemos considerar o uso das estratégias de processamento simultâneo?

@) Quais são as três estratégias de processamento simultâneo que foram estudas?


# Praticando

<!-- Um atômico -->

@) Projete uma função que verifique se todos os elementos de uma lista estão presentes em outra lista.

@) Projete uma função que calcule todos os possíveis pares entre os elementos de duas listas. Dica: projete uma função auxiliar que crie os pares entre um elemento e os elementos de uma lista.

    ```gleam
    > pares([3, 1, 8], [7, 4])
    [[3, 7], [3, 4], [1, 7], [1, 4], [8, 7], [8, 4]]
    ```


<!-- Sincronizado -->

@) Projete uma função que receba como parâmetro uma lista de nomes e uma lista booleanos, onde cada elemento verdadeiro indica que o nome corresponde deve ser selecionado, e crie uma lista selecionando esses nomes.

    ```gleam
    > seleciona(["Jorge", "Amanda", "Pedro", "Joana"], [True, False, False, True])
    ["Jorge", "Joana"]
    ```

@) Projete uma função que verifique se duas listas de números são iguais (não use o operador `==` para comparar as duas listas diretamente).


<!-- Combinações -->

@) Projete uma função que receba como parâmetro duas listas e verifique se a primeira tem mais elementos que a segunda (não use a função `list.length` e nem operações aritméticas na implementação).

@) Projete uma função que devolva uma lista com os $n$ primeiros elementos de uma lista de entrada.

    ```gleam
    > mantem([10, 40, 70, 20, 3], 2)
    [10, 40]
    ```

@) Projete uma função que devolva uma lista sem os $n$ primeiros elementos de uma lista de entrada.

    ```gleam
    > descarta([10, 40, 70, 20, 3], 2)
    [70, 20, 3]
    ```

@) Projete uma função que gere uma lista a partir da lista de entrada, removendo o elemento de uma dada posição.

    ```gleam
    > remove_em([3, 6, 1, 2], 2)
    [3, 6, 2]
    ```

@) Projete uma função que gere uma lista a partir da lista de entrada, inserindo um elemento em uma dada posição.

    ```gleam
    > insere_em([3, 6, 1, 2], 5, 2)
    [3, 6, 5, 1, 2]
    ```


# Resolvendo problemas

<!-- Um atomico -->

@) Em um sítio para pessoas que gostam de ler livros os usuários registram os livros que estão lendo atualmente, os livros que já leram no passado, os que mais gostaram, entre outras informações. Uma das funcionalidades do sítio é encontrar leitores que tenham lido os mesmos livros e sugerir a formação de comunidades. Como parte do sistema do sítio é necessário criar uma função que recebe como parâmetro duas listas de livros e indique quantos livros aparecem nas duas listas.

<!-- Sincronizado -->

@) A prova de vestibular de uma determina Universidade consiste de diversas questões de múltipla escolha com 5 opções cada. Os candidatos preenchem uma folha de respostas que depois é lida por uma máquina e armazenada em um bando de dados. Após todos as folhas de respostas terem sido lidas, o sistema deve prosseguir para determinar a nota (quantidade de acertos) de cada candidato. O gabarito é representado por uma lista com as alternativas corretas das questões, o primeiro elemento da lista é a alternativa correta da primeira questão, o segundo elemento da lista é a alternativa correta da segunda questão, e assim por diante. A resposta de uma candidato é representado de forma semelhante, sendo que os valores da lista são as alternativas assinaladas. Projete uma função que determine a partir de um gabarito e uma folha de respostas, quantas questões um candidato acertou.

<!-- Combinações -->

@) Em uma aplicativo de tarefas, os usuários criam listas de tarefas e definem prioridades (número inteiro) para cada tarefa. As tarefas são mantidas em ordem de prioridade, com as de maiores prioridades na frente. Um pedido comum dos usuários é poder juntar duas listas de tarefas de maneira que a lista resultante tenha as tarefas das duas listas em ordem de prioridade. Projete uma função que possa ser usada para atender esse pedido dos usuários.
