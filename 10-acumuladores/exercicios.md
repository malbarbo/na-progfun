---
# vim: set spell spelllang=pt_br sw=4:
title: |
       | Programação Funcional
       | Acumuladores
urlcolor: Blue
license:
# TODO: adicionar mais exercícios
# TODO: adicionar soluções
---

# Começando

@) O que é um acumulador?

@) O que é um processo recursivo? E um processo iterativo?

@) O que é uma função recursiva em cauda?

@) Qual é a relação entre recursão em cauda e processos iterativos?

@) Que perguntas precisamos responder para projetar uma função com acumulador?


# Praticando

@) Analise os exemplos e exercícios de listas e reescreva as funções, se houver benefício, usando acumuladores. Siga o processo visto em sala para projetar as funções e faça a análise do tempo de execução. Utilize a função `fold` onde for apropriado.


# Resolvendo problemas

@) Em um jogo de sobrevivência um personagem se move por um mundo aberto tridimensional formado por cubos do mesmo tamanho. Cada posição (cubo) do mapa tem uma coordenada $(X, Y, Z)$ e cada componente da coordenada pode assumir qualquer valor inteiro (o mapa é infinito!). O personagem pode se deslocar um cubo por vez, seja para o norte, sul, leste ou oeste ou para cima ou para baixo. Projete uma função que receba a posição do personagem e uma sequência de deslocamentos e calcule a nova posição do personagem.

@) O Pedro está com dificuldades em gerenciar os seus gastos e por isso fez uma acordo consigo mesmo: toda vez que a conta ficar negativa, ele fará uma doação de 10 reais para um entidade social. Ele tem anotado o saldo inicial da sua conta, e todos os gastos e recebimentos que teve em um período, os gastos com valores negativos e os recebimentos com valores positivos, agora ele precisa da sua ajuda para calcular quanto deve doar. Projete uma função para resolver o problema do Pedro.
