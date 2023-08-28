---
# vim: set spell spelllang=pt_br sw=4:
title: Tipos de dados - Prática
urlcolor: Blue
---

<!-- Enumerações -->

@. Projete uma enumeração para representar as direções norte, leste, sul e oeste. Em seguida,

    a) Projete uma função que indique a direção oposta de uma direção.

    a) Projete uma função que indique qual é direção que está a 90 graus no sentido horário de outra direção.

    a) Projete uma função que indique qual é direção que está a 90 graus no sentido anti-horário de outra direção. Use a função do item b para fazer a implementação (não use seleção nem operações aritméticas nessa implementação).

@. Projete uma enumeração para representar o estado de um elevador que pode estar parado, subindo ou descendo. Em seguida,

    a) Sabendo que um elevador está parado e irá atender imediatamente uma solicitação, projete uma função que determine, a partir do andar atual e do andar solicitado, qual será a condição do elevador ao atender a solicitação.

    b) Sabendo que um elevador só pode começar a se movimentar se estiver parado, projete uma função que verifique se o elevador pode passar de um estado para outro. Faça uma tabela que mostre as nove possibilidades de entrada da função e a saída de cada possibilidade. Faça os exemplos a partir da tabela. Faça a implementação simplificada a partir da tabela.


<!-- Estruturas -->

@. Projete um estrutura para representar uma data com dia, ano e mês. Em seguida

    a) Projete uma função que verifique se uma data é o último dia do ano.

    a) Projete uma função que receba duas datas e produza verdadeiro se a primeira vem antes que a segunda.

    a) (Desafio) Projete uma função que verifique se uma data é válida. Considere que em anos bissextos fevereiro tem 29 dias e que um ano é bissexto se é múltiplo de 400 ou é múltiplo de 4 mas não é múltiplo de 100.

@. Projete uma estrutura para representar resoluções (altura e largura em pixels) de telas e imagens. Em seguida

    a) Projete uma função que determine quantos mega pixels uma imagem tem dada a sua resolução. O número de megapixel pode ser caculado multiplicando-se a altura e largura e dividindo-se por 1 milhão.

    a) Projete uma função que receba duas resoluções, uma de uma imagem e outra de uma tela, e verifique se a imagem pode ser exibida completamente na tela sem a necessidade de rotação ou redução de tamanho.

    a) Projete uma função que indique se uma resolução tem aspecto (razão entre largura e altura) de 4:3, 16:9 ou outro (projete um tipo enumerado para representar o aspecto). Por exemplo, a resolução $1080 \times 1920$ tem aspecto 16:9, pois $1080 \times 16 = 1920 \times 9$.

    <!-- TODO: adicionar um item sobre fator de escala -->


<!-- Uniões -->

@. Projete uma união para representar uma figura, que pode ser um retângulo, com largura e altura, ou um círculo, com raio. Em seguida,

    a) Projete uma função que determine a área de uma figura. A área de um retângulo é dado por ${largura} \times {altura}$ e a área de um círculo é dado por $3.14 \times {raio}^2$.

    a) Projete uma função que verifique se uma figura cabe dentro de outra. Faça uma tabela com as quatro possibilidade (retângulo - retângulo, retângulo - círculo, círculo - retângulo, círculo - círculo) e identifique as condições necessárias para a primeira figura caber dentro da segunda (um retângulo cabe dentro de um círculo se a sua diagonal ($\sqrt{ {altura}^2 + {largura}^2}$) é menor que diâmetro do círculo ($2 \times {raio}$)). Faça os exemplos e a implementação a partir da tabela.
