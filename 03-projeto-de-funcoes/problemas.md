---
# vim: set spell spelllang=pt_br sw=4:
title: Projeto de funções - Problemas
urlcolor: Black
license:
# TODO: deixar apenas um exercício de porcentagem
---

@) Você está fazendo um programa e precisa verificar se um texto digitado pelo usuário está de acordo com algumas regras. A regra “sem espaços extras” requer que o texto não comece e não termine com espaços. Projete uma função que verifique se um texto qualquer está de acordo com a regra “sem espaços extras”.

@) Cada cidadão de um país, cuja moeda chama dinheiro, tem que pagar imposto sobre a sua renda. Cidadãos que recebem até 1000 dinheiros pagam 5% de imposto. Cidadãos que recebem entre 1000 e 5000 dinheiros pagam 5% de imposto sobre 1000 dinheiros e 10% sobre o que passar de 1000. Cidadãos que recebem mais do 5000 dinheiros pagam 5% de imposto sobre 1000 dinheiros, 10% de imposto sobre 4000 dinheiros e 20% sobre o que passar de 5000. Projete uma função que calcule o imposto que um cidadão deve pagar dado a sua renda.

@) Uma palavra duplicada é formada pela ocorrência de duas partes iguais, separadas ou não por hífen. Por exemplo, as palavras xixi, mimi, lero-lero e mata-mata são palavras duplicadas. Projete uma função que verifique se uma palavra é duplicada.

@) Um construtor precisa calcular a quantidade de azulejos necessários pra azulejar uma determinada parede. Cada azulejo é quadrado e tem 20cm de lado. Ajude o construtor e defina uma função que receba como entrada o comprimento e a altura em metros de uma parede e calcule a quantidade de azulejos inteiros necessários para azulejar a parede. Considere que o construtor nunca perde um azulejo e que recortes de azulejos não são reaproveitados.

@) Rotacionar uma string `n` posições a direita significa mover os últimos `n` caracteres da string para as primeiras `n` posições da string. Por exemplo, rotacionar a string `"marcelio"` 5 posições a direita produz a string `"celiomar"`. Projete uma função que receba como entrada uma string e um número `n` e produza uma nova string rotacionando a string de entrada `n` posições a direita.

@) Um banco emprega diferentes taxas de correção anual para um investimento dependendo do valor aplicado no início de cada ano. Para valores até R$ 2000 a taxa de correção é de 10%, para valores entre R$ 2000 e R$ 5000 a taxa de correção é de 12%, para valores maiores que R$ 5000 a taxa de correção é de 13%.

    a) Projete uma função que calcule quanto um investimento realizado no início do ano irá render após um ano aplicado no banco.

    b) Projete uma função que calcule quanto um investimento realizado no início do ano irá render após dois anos aplicado no banco. Dica: use a função do item a para fazer a implementação.

@) No período de 2015 à 2016 todos os números de telefones celulares no Brasil passaram a ter nove dígitos. Na época, os números de telefones que tinham apenas oito dígitos foram alterados adicionando-se o 9 na frete do número. Embora oficialmente todos os número de celulares tenham nove dígitos, na agenda de muitas pessoas ainda é comum encontrar números registrados com apenas oito dígitos. Projete uma função que adicione o nono dígito em um dado número de telefone celular caso ele ainda não tenha o nono dígito. Considere que os números de entrada são dados com o DDD entre parênteses e com um hífen separando os últimos quatro dígitos. Exemplos de entradas: (44) 9787-1241, (51) 95872-9989, (41) 8876-1562. A saída deve ter o mesmo formato, mas garantindo que o número do telefone tenha 9 dígitos.

@) Muitos letreiros exibem mensagens que tem mais caracteres do que eles podem exibir, para isso, eles exibem apenas uma porção da mensagem que é alterada com o passar do tempo. Por exemplo, em um letreiro de 20 caracteres, a mensagem `"Promocao de sorvetes, pague 2 leve 3!"` é exibida como `Promocao de sorvetes` no momento 0, como `"romocao de sorvetes,"` no momento 1, `"omocao de sorvetes, "`, no momento 3, e assim por diante até que no momento 17 é exibido `"tes, pague 2 leve 3!"`. O momento sempre aumenta, e após chegar no final da mensagem ela começa a ser exibida novamente, nesse caso, no momento 18 é exibido `"es, pague 2 leve 3! "` e no momento 19 é exibido `"s, pague 2 leve 3! P"`, onde o `P` é o início da mensagem. Projete uma função que determine os caracteres de uma mensagem que devem ser exibidos em um determinado momento em um letreiro que pode exibir um determinado número de caracteres. Assuma que o número de caracteres da mensagem é maior do que o do letreiro.

@) (Desafio) Um número inteiro positivo é palíndromo se quando lido da direita para a esquerda ou da esquerda para a direita é idêntico. Ex: 9119, 1221, 5665, 7337. Projete uma função que verifique se um dado número inteiro de 4 dígitos é palíndromo, considere que o valor de entrada é o próprio número e não os quatro dígitos que compõem o número. É possível modificar a sua função de maneira que ela funcione para qualquer número de entrada e não apenas para números de 4 dígitos?
