---
# vim: set spell spelllang=pt_br sw=4:
title: |
       | Programação Funcional
       | Recursão estrutural: naturais
urlcolor: Blue
license:
---

# Começando

@) Dê um exemplo de função em que um número natural de entrada deve ser visto como um dado composto e outro em que ele deve ser visto como um dado atômico.

@) Escreva o modelo de função para números naturais e explique a relação de cada caso do modelo com a definição de número natural.

@) Dê um exemplo de problema em que a recursão deve parar em um valor diferente de $0$. Escreva o modelo de função para esse problema e indique quais casos mudam em relação ao modelo para números naturais e quais permanecem iguais.


# Praticando

<!-- Natural -->

@) Projete uma função que receba como entrada um número natural $n$ e um valor $v$ e crie uma nova lista com $n$ repetições do valor $v$.

@) Projete uma função que receba como entrada um número $a$ e um número natural $n$ e calcule o valor $a^n$. A função deve ser total: se $n$ for negativo, ela deve indicar um erro.

@) Projete uma função que receba como entrada um número natural $n$ e calcule o produto dos números $1, 2, \dots, n$.

@) Recursão indireta é quando duas ou mais funções chamam uma à outra. Projete duas funções, `par` e `impar`, que recebam como entrada um número natural e determinem se ele é par ou ímpar, respectivamente. A função `par` deve chamar a `impar`, e a `impar` deve chamar a `par`. As funções devem ser totais: se a entrada for negativa, elas devem indicar um erro.

<!-- Inteiro maior ou igual a x -->

@) Projete uma função que receba como entrada dois inteiros $a$ e $b$ e devolva a lista com os inteiros $a, a + 1, \dots, b$. Se $b < a$, a função deve devolver a lista vazia. Use o modelo para inteiros maiores ou iguais a $a$.


# Resolvendo problemas

<!-- Inteiro maior ou igual a x -->

@) Em um determinado jogo de construção de itens, cada item tem uma classe que varia de 1 a 10. Os itens de classe 1 surgem conforme o jogador explora os baús. Um item de classe 2 ou superior precisa ser construído unindo dois itens da classe anterior. Por exemplo, para construir um item de classe 2 é necessário unir dois itens de classe 1. Para construir um item de classe 10 é necessário unir dois itens de classe 9. Projete uma função total que receba como entrada a classe de um item e determine quantos itens de classe 1 são necessários para construí-lo. Suponha que as únicas operações aritméticas disponíveis sejam a soma e a multiplicação.

<!-- Natural -->

@) Um aplicativo de lembretes de medicamentos precisa mostrar os horários das doses. O usuário informa a hora da primeira dose, o intervalo em horas entre as doses e quantas doses vai tomar. Por exemplo, começando às 22 horas, de 8 em 8 horas, com 4 doses, os horários são 22, 6, 14 e 22. Projete uma função total que produza a lista com os horários das doses.

@) Programas de terminal costumam mostrar o andamento de uma tarefa com uma barra de 10 posições, em que cada posição preenchida representa 10% concluído. Por exemplo, para 40% a barra é `[####------]`, e para 45% também, já que a posição só é preenchida quando os 10% são completados. Projete uma função total que receba a porcentagem concluída e produza a barra correspondente.
