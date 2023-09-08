---
# vim: set spell spelllang=pt_br sw=4:
# TODO: adicionar exercícios de map
title: Autorreferência e recursividade - Problemas
---

@. O Tarcísio tem uma padaria que vende diversos tipos de pães, como italiano, de milho, 7 grãos, etc. Ele tem uma planilha com o tipo de pão e quantidade que foi vendida, agora ele precisa saber qual o tipo de pão que mais vende. Você pode ajudar o Tarcísio?

@. O mestrando em física Alberto está tendo problemas com o equipamento que ele está usando para medir a temperatura de um material. O equipamento faz uma leitura a cada 10 segundos, mas ao invés de gerar apenas um número (temperatura), por vez, ele está gerando o mesmo número diversas vezes a cada leitura. Como o Alberto não tem verba para consertar o equipamento, ele está contando com a sua ajudar para fazer um programa que corrigi os dados lido pelo equipamento. Note que ele espera que cada leitura seja maior que a anterior, então se o equipamento ler os valores 3, 3, 7, 7, 7, 10 a leitura esta errada, o correto seria 3, 7, 10.

<!--

#. Defina uma função que receba com entrada uma lista `lst` e um elemento `a` e devolva uma lista que é como `lst` mas sem as ocorrências de `a`.

    ```scheme
    > (remove-todos (list 3 2 3 5 8 3) 3)
    '(2 5 8)
    ```


#. Defina uma função que receba como entrada uma lista `lst` de números em ordem não decrescente e um número `n` e devolva uma lista com os elementos de `lst` e com `n` em ordem não decrescente.

    ```scheme
    > (insere-ordenado (list 2 8 10) 5)
    '(2 5 8 10)
    ```

#. Defina uma função que receba como entrada uma lista de números e devolva uma lista com os mesmos valores de entrada mas em ordem não decrescente. (Lembre-se de aplicar a receita de projeto, não tente implementar um método de ordenação qualquer, a receita te levará a implementar um método específico). Dica: use a função `insere-ordenado`.

-->
