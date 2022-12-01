---
# vim: set spell spelllang=pt_br sw=4:
title: Motivação
license:
---

No Campeonato Brasileiro de Futebol, também chamado de Brasileirão, diversos times disputam o título de melhor time do Brasil.

Os times jogam todos contra todos em dois turnos, ida e volta, e vão acumulando pontos. Cada vitória gera três pontos, cada empate um ponto e a derrota não gera pontos. Os times são classificados de acordo com o seu desempenho, de forma que o time que tem melhor desempenho, fica na frente do time que tem menos pontos. O desempenho é determinado primeiramente pelo número de pontos, se dois ou mais times tem o mesmo número de pontos, então, os seguintes critérios são utilizados para o desempate: número de vitórias, saldo de gols (número de gols feito menos o número de gols sofridos) e ordem alfabética (Sim, é injusto! Mas essa é uma simplificação...).

Projete uma função (usando o paradigma funcional) que receba como entrada uma lista de strings que descreve os resultados dos jogos e produza um lista de strings com a classificação dos times.

O programa deve funcionar de forma genérica, para qualquer quantidade de resultados e para quaisquer times que apareçam nos resultados.

Cada string da lista de entrada tem o resultado de um jogo, escrito da forma "Anfitrião Gols Visitante Gols" (os nomes dos times anfitrião e visitante não têm espaço). Por exemplo, a linha "Sao-Paulo 3 Flamengo 1", descreve o jogo em que o Sao-Paulo era anfitrião e marcou 3 gols e o Flamengo era visitante e marcou 1 gol.

Supondo que a lista de entrada seja

```txt
Sao-Paulo 1 Atletico-MG 2
Flamengo 2 Palmeiras 1
Palmeiras 0 Sao-Paulo 0
Atletico-MG 1 Flamengo 2
```

O seu programa deve produzir a seguinte lista de strings (uma string por linha) de saída

```txt
Flamengo 6 2 2
Atletico-MG 3 1 0
Palmeiras 1 0 -1
Sao-Paulo 1 0 -1
```

Onde depois do nome do time aparece o número de pontos, o número de vitórias e o saldo de gols. Se você quiser ir além, pode formatar a saída para ficar mais legível

```txt
Flamengo     6  2   2
Atletico-MG  3  1   0
Palmeiras    1  0  -1
Sao-Paulo    1  0  -1
```

Note que internamente o seu programa deve trabalhar com estruturas, ele não deve trabalhar com strings nem para o resultado e nem para o desempenho. Dessa forma, a primeira coisa que seu programa deve fazer é transformar a lista de strings de entrada em uma lista de resultados e a última coisa deve ser transformar a classificação em uma lista de strings.

Resolver este problema "de uma" vez é complicado, então você deve decompô-lo em subproblemas menores. Para isso você pode usar o pensamento desejoso e desejar por funções auxiliares que resolvam esses subproblemas e implementar essas funções depois.

A seguir eu sugiro uma forma de decompor o problema, você pode usar essa decomposição ou criar a sua própria.

- Descobrir os nomes dos times
- Calcular os pontos, número de vitórias e saldo de gols de um time por vez
- Classificar os times de acordo com o desempenho de cada um
