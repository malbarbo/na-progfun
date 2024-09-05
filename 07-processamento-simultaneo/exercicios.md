---
# vim: set spell spelllang=pt_br sw=4:
title: |
       | Programação Funcional
       | Processamento simultâneo
urlcolor: Blue
license:
# TODO: adicionar mais exercícios com duas listas de entrada
# TODO: adicionar mais problemas
# TODO: colocar quantidade de exercícios similar para cada estratégia
---

# Começando

@) Quando devemos considerar o uso das estratégias de processamento simultâneo?

@) Quais são as três estratégias de processamento simultâneo que foram estudas?


# Praticando

<!-- Um atômico -->

@) Projete uma função que verifique se todos os elementos de uma lista estão presentes em outra lista.

@) Projete um função que calcule todos os possíveis pares entre os elementos de duas listas com números distintos.

    ```scheme
    > (produto (list 3 1 8) (list 7 4))
    '((par 3 7) (par 3 4) (par 1 7) (par 1 4) (par 8 7) (par 8 4))
    ```


<!-- sincronizado -->

@) Projete a função que receba como parâmetro uma lista de nomes e uma lista de idades e combine os valores das listas, que devem ter o mesmo tamanho, em uma lista de registros de pessoas

    ```scheme
    > (zip (list "Jorge" "Amanda" "Joana") (list 41 12 26))
    '((pessoa "Jorge" 41) (pessoa "Amanda" 12) (pessoa "Joana" 26))
    ```

<!-- Combinações -->

@) Projete uma função que verifique se duas listas de números são iguais (não use a função `equal?` na implementação!).

@) Projete uma função que receba como parâmetro duas listas e verifique se a primeira tem mais elementos que a segunda (não use a função `length` e nem operações aritméticas na implementação).

@) Projete uma função que devolva os $n$ primeiros elementos de uma lista.

    ```scheme
    > (mantem (list 10 40 70 20 3) 2)
    '(10 40)
    ```

@) Projete uma função que devolva um nova lista sem os $n$ primeiros elementos de uma dada lista.

    ```scheme
    > (descarta (list 10 40 70 20 3) 2)
    '(70 20 3)
    ```

@) Projete uma função que devolva uma nova lista que é como a lista de entrada mas sem o elemento de uma dada posição.

    ```scheme
    > (remove-em (list 3 6 1 2) 2)
    '(3 6 2)
    ```

@) Projete uma função que devolva uma lista que é como a lista de entrada mas com um dado elemento inserido em uma dada posição.

    ```scheme
    > (insere-em (list 3 6 1 2) 5 2)
    '(3 6 5 1 2)
    ```

@) Defina uma função que receba como entrada duas listas de números em ordem crescente, e devolva uma nova lista com os elementos das duas listas de entrada em ordem crescente.

    ```scheme
    > (intercala (list 3 7 12) (list 2 4 5))
    '(2 3 4 5 7 12)
    ```


# Resolvendo problemas

<!-- um atomico -->

@) Em um sítio para pessoas que gostam de ler livros os usuários registram os livros que estão lendo atualmente, os livros que já leram no passado, os que mais gostaram, entre outras informações. Uma das funcionalidades do sítio é encontrar leitores que tenham lido os mesmos livros e sugerir a formação de comunidades. Como parte do sistema do sítio é necessário criar uma função que recebe como parâmetro duas listas de livros e indique quantos livros aparecem nas duas listas.

<!-- sincronizado -->

@) A prova de vestibular de uma determina Universidade consiste de diversas questões de múltipla escolha com 5 opções cada. Os candidatos preenchem uma folha de respostas que depois é lida por uma máquina e armazenada em um bando de dados. Após todos as folhas de respostas terem sido listas, o sistema deve prosseguir para determinar a nota (quantidade de acertos) de cada candidato. O gabarito é representado por uma lista com as alternativas corretas das questões, o primeiro elemento da lista é a alternativa correta da primeira questão, o segundo elemento da lista é a alternativa correta da segunda questão, e assim por diante. A resposta de uma candidato é representado de forma semelhante, sendo que os valores da lista são as alternativas assinaladas. Projete uma função que determine quantas a partir de um gabarito e uma folha de respostas, quantos questões uma candidato acertou.

<!-- combinações -->

