---
# vim: set spell spelllang=pt_br sw=4:
title: |
       | Programação Funcional
       | Funções totais
urlcolor: Blue
license:
# TODO: adicionar mais exercícios de result e option
---

# Começando

@) Quando o tipo `Option` é adequado e quando o tipo `Result` é mais adequado? Descreva uma situação para cada caso.

@) Por que devolver um valor especial (como -1) para indicar a ausência de um resultado é pior do que devolver um `Option`? Explique.

@) O que é um tipo opaco e qual problema ele resolve? Dê um exemplo de informação cuja representação se beneficia dessa técnica.

@) Quais são os três caminhos para tornar uma função total? Dê um exemplo de função em que escolher uma resposta para as entradas inválidas generaliza o propósito, e um exemplo em que apenas preenche um buraco.

@) Por que a biblioteca padrão do Gleam usa `Result(a, Nil)` em vez de `Option(a)` para funções que podem falhar?

@) O que significa dizer que o `Option` se propaga? Como isso aparece no tipo das funções que usam o resultado de uma função que devolve `Option`?


# Praticando

<!-- Option -->

@) Projete uma união para representar um espectador de uma sala de cinema, que pode ser uma criança, um jovem, um adulto ou um idoso. Um jovem pode opcionalmente apresentar sua carteirinha com um código numérico de estudante. Em seguida,

    a) Projete uma função que retorne o número da carteirinha de estudante, caso o espectador a tenha.

    b) Projete uma função que retorne um valor booleano indicando se o espectador tem direito ou não a um desconto no ingresso. Crianças e idosos sempre têm desconto. Um adulto não tem desconto. E um jovem só tem desconto se tiver uma carteirinha de estudante.

@) Projete uma função que receba dois `Option(Int)` e devolva `Some` da soma dos dois valores apenas se os dois estiverem presentes, e `None` caso contrário.


<!-- Result -->

@) Projete uma função que receba o número de um mês em forma de string e devolva a quantidade de dias desse mês, considerando um ano não bissexto. A função deve falhar se a string não representar um número ou se o número não estiver entre 1 e 12. Em seguida, defina um tipo de erro com as variantes `NaoNumero` e `ForaDaFaixa` e modifique a função para devolver esse tipo em vez de `Nil`.


<!-- TAD -->

@) Projete um tipo opaco para representar uma data com dia, mês e ano, com uma função construtora que valide o valor e devolva um `Result`. Em seguida,

    a) Projete uma função que receba como entrada uma string que representa uma data no formato "dd/mm/aaaa" e a converta para a data equivalente. A validação inicial no construtor deve verificar apenas se as partes são números.

    b) Projete uma função que verifique se uma data corresponde ao último dia do ano.

    c) Projete uma função que receba duas datas e produza `True` se a primeira data ocorrer antes da segunda.

    d) (Desafio) Modifique o construtor de maneira que ele verifique se uma data é válida. Considere que, em anos bissextos, fevereiro tem 29 dias e que um ano é bissexto se for múltiplo de 400 ou se for múltiplo de 4, mas não de 100.

@) Projete um tipo opaco para representar uma duração com horas e minutos, com uma função construtora que valide os valores (as horas não podem ser negativas e os minutos devem estar entre 0 e 59) e devolva um `Result`. Em seguida,

    a) Projete uma função que converta uma quantidade total de minutos na duração equivalente.

    b) Projete uma função que some duas durações.

    c) Projete uma função que converta uma duração em uma string amigável para o usuário, omitindo as horas ou os minutos quando o valor for zero.


# Resolvendo problemas

@) Jokenpô é um jogo recreativo bastante conhecido no Brasil. Nele, dois participantes esticam a mão simultaneamente e formam um símbolo, que pode ser pedra, papel ou tesoura. A decisão de quem ganha é feita da seguinte forma: a pedra vence a tesoura, a tesoura vence o papel e o papel vence a pedra. Projete uma função que determine, a partir dos nomes e dos símbolos escolhidos pelos dois jogadores, quem venceu a rodada.

@) Um caixa eletrônico só entrega notas de 20 e 50 reais. Projete uma função que receba um valor de saque e determine a quantidade de notas de cada tipo que devem ser entregues, ou falhe se o valor não puder ser formado com essas notas. Por exemplo, para 90 reais devem ser entregues 2 notas de 20 e 1 nota de 50, e 30 reais não pode ser sacado.
