---
# vim: set spell spelllang=pt_br sw=4:
# TODO: adicionar mais exercícios e identificar o que é usado em cada
title: Autorreferência e recursividade - Problemas
urlcolor: Blue
---

@. Júlia tem uma pequena empresa de sorvetes que vende três sabores diferentes: manga, uva e morango. Cada sorvete é vendido por 10 reais, mas o custo de produção de cada sorvete depende do sabor: o de manga custa 6, o de uva 7 e o de morango 8. Toda vez que a Júlia vende um sorvete ela anota o sabor em uma lista. Após ter anotado os sabores dos sorvetes vendidos em uma lista, é hora de calcular quanto foi o ganho, e para isso a Júlia precisa da sua ajuda. Projete uma função que receba como entrada uma lista com os sabores dos sorvetes vendidos e calcule qual foi o ganho da Júlia vendendo os sorvetes.

@. O mestrando em física Alberto está tendo problemas com o equipamento que ele está usando para medir a temperatura de um material. O equipamento faz uma leitura a cada 10 segundos, mas ao invés de gerar apenas um número (temperatura), por vez, ele está gerando o mesmo número diversas vezes a cada leitura. Como o Alberto não tem verba para consertar o equipamento, ele está contando com a sua ajudar para fazer um programa que corrigi os dados lido pelo equipamento. Note que ele espera que cada leitura seja maior que a anterior, então se o equipamento ler os valores 3, 3, 7, 7, 7, 10 a leitura esta errada, o correto seria 3, 7, 10.


<!-- Funções auxiliares - plano -->

@. A Láurea Acadêmica é uma homenagem prestada a alunos que tiveram elevado nível de aproveitamento no curso de graduação. Na UEM, todos os alunos que tiveram mais do que 2/3 das notas finais das disciplinas maiores do que 9,0 recebem esta homenagem. Projete um programa que receba as notas finais de um aluno e determine se ele receberá a Láurea Acadêmica. Dica: faça um plano.

@. Uma eleição é realizada com apenas dois candidatos. Cada eleitor pode votar ou no primeiro candidato, ou no segundo candidato, ou ainda, votar em branco. O candidato que tiver mais votos ganha a eleição. Se os votos em branco forem mais do que 50% do total de votos, novas eleições devem ser convocadas. Projete uma função que receba como entrada uma lista não vazia de votos e determine qual foi o resultado da eleição. Dica: faça um plano.

@. Uma dos problemas mais conhecidos de programação é o problema de ordenação. Existem diversos métodos já estabelecidos de ordenação, como a ordenação por seleção e intercalação. O uso do modelo para funções que processam listas leva a uma implementação específica. Projete uma função usando o modelo para listas que ordene uma lista de números. Dica: deseje por uma função auxiliar para combinar o primeiro elemento com o resultado da chamada recursiva. Como é conhecido esse método de ordenação?
