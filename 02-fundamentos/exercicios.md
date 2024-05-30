---
# vim: set spell spelllang=pt_br sw=4:
title: |
       | Programação Funcional
       | Fundamentos
urlcolor: Blue
license:
# TODO: exercícios de estratégia de avaliação
---

# Começando

@) O que é um literal?

@) O que é uma função primitiva?

@) O que é uma expressão?

@) O que significa avaliar uma expressão?

@) O que é uma combinação?

@) Como é chamado a expressão mais a esquerda de uma combinação? E as demais expressões?

@) Qual é a regra de avaliação para uma combinação?

@) Qual é o propósito de uma definição?

@) O que é uma função?

@) O que é uma forma especial?

@) Por que o `and`{.scheme} e o `or`{.scheme} são formas especiais e o `not`{.scheme} não é?

@) A ordem que as expressão de uma combinação são avaliadas pode alterar o valor da combinação? Explique.

@) Quando devemos utilizar o operador `=`{.scheme}?

@) Qual a diferença entre as funções `eq?`{.scheme} e `equal?`{.scheme}?

@) O que é uma definição com autorreferência?

@) O que é um processo recursivo?


# Praticando

@) Escreva a expressão $(3 + 1) \times 8 / (4 - 1)$ em Racket.

@) Qual o resultado da avaliação da expressão `(* 3 (+ 1 2) (/ 10 2) 2)`{.scheme}? Mostre o passo a passo da avaliação.

@) Qual o resultado da avaliação de `(3 + 8)`{.scheme} na janela de interações do Racket? E de `3 + 8`{.scheme}. Explique.


<!-- Funções diretas com números e strings -->

Para implementar os exercícios a seguir, use apenas as funções primitivas presentes no material "Resumo da linguagem Racket" disponível na página da disciplina.

@) Faça uma função chamada `area-retangulo` que recebe dois argumentos, a `largura` e a `altura` de um retângulo, e calcula a sua área. Confira na janela de interações se a função funciona de acordo com os exemplos a seguir

    ```scheme
    > (area-retangulo 3 5)
    15
    > (area-retangulo 2.0 2.5)
    5.0
    ```


@) Faça uma função chamada `produto-anterior-posterior` que recebe um número inteiro `n` e calcula o produto de `n`, `n + 1` e `n - 1`. Use o método de substituição para verificar se a sua função funciona corretamente de acordo com os exemplos a seguir. Em seguida confira a respostas na janela de iterações do DrRacket.

    ```scheme
    > (produto-anterior-posterior 3)
    24
    > (produto-anterior-posterior 1)
    0
    > (produto-anterior-posterior -2)
    -6
    ```


@) Faça uma função chamada `so-primeira-maiuscula` que recebe uma palavra não vazia (string) como parâmetro e crie uma nova string convertendo a primeira letra da palavra para maiúscula e o restante da palavra para minúscula. Use o método de substituição para verificar se a sua função funciona corretamente de acordo com os exemplos a seguir. Em seguida confira a respostas na janela de iterações do DrRacket.

    ```scheme
    > (so-primeira-maiuscula "paula")
    "Paula"
    > (so-primeira-maiuscula "ALFREDO")
    "Alfredo"
    ```


@) Faça uma função chamada `exclamacao` que recebe dois argumento, uma string `frase` e um número natural `n`, e produz a mesma frase adicionando `n` pontos de exclamação no final da frase. Use o método de substituição para verificar se a sua função funciona corretamente de acordo com os exemplos a seguir. Em seguida confira a respostas na janela de iterações do DrRacket.

    ```scheme
    > (exclamacao "Nossa" 3)
    "Nossa!!!"
    > (exclamacao "Que legal" 1)
    "Que legal!"
    > (exclamacao "Nada" 0)
    "Nada"
    ```

<!-- Predicados -->

@) Faça uma função chamada `par?` que recebe um número natural `n` e indica se `n` é par. Um número é par se o resto da divisão dele por 2 é igual a zero. Não use `if`{.scheme} nem `cond`{.scheme} e nem a função pré-definida `even?`{.scheme}. Use o método de substituição para verificar se a sua função funciona corretamente de acordo com os exemplos a seguir. Em seguida confira a respostas na janela de iterações do DrRacket.

    ```scheme
    > (par? 3)
    #f
    > (par? 6)
    #t
    ```


@) Faça uma função chamada `tres-digitos?` que recebe um número natural `n` e verifica se `n` tem exatamente 3 dígitos. Não use `if`{.scheme} nem `cond`{.scheme}. Use o método de substituição para verificar se a sua função funciona corretamente de acordo com os exemplos a seguir. Em seguida confira a respostas na janela de iterações do DrRacket.

    ```scheme
    > (tres-digitos? 99)
    #f
    > (tres-digitos? 100)
    #t
    > (tres-digitos? 999)
    #t
    > (tres-digitos? 1000)
    #f
    ```

<!-- Condicional -->

@) Faça uma função `maximo` que encontre o máximo entre dois números dados. Não use a função pré-definida `max`{.scheme}. Use o método de substituição para verificar se a sua função funciona corretamente de acordo com os exemplos a seguir. Use o método de substituição para verificar se a sua função funciona corretamente de acordo com os exemplos a seguir. Em seguida confira a respostas na janela de iterações do DrRacket.

    ```scheme
    > (maximo 3 5)
    5
    > (maximo 8 4)
    8
    > (maximo 6 6)
    6
    ```


@) Faça uma função chamada `ordem` que recebe três números distintos, `a`, `b` e `c` e determina se a sequencia `a, b, c` está em ordem crescente, decrescente ou não está em ordem. Use os operadores relacionas com três argumentos. Use o método de substituição para verificar se a sua função funciona corretamente de acordo com os exemplos a seguir. Em seguida confira a respostas na janela de iterações do DrRacket.

    ```scheme
    > (ordem 3 8 12)
    "crescente"
    > (ordem 3 1 4)
    "sem ordem"
    > (ordem 3 1 0)
    "decrescente"
    ```

<!-- Desafios -->

@) [sicp 1.4] O modelo de avaliação visto em sala permite combinações em que os operadores são expressões compostas. Use esta observação para descrever o comportamento do seguinte procedimento:

    ```scheme
    (define (a-plus-abs-b a b)
        ((if (> b 0) + -) a b))
    ```

@) [sicp 1.5] Ben Bitdiddle inventou um método para determinar se um interpretador está usando avaliação com ordem aplicativa ou avaliação com ordem normal. Ele definiu os seguintes procedimentos:

    ```scheme
    (define (p) (p))

    (define (test x y)
      (if (= x 0)
          0
          y))
    ```

    Então avaliou a seguinte expressão

    ```scheme
        (test 0 (p))
    ```

    Qual é o comportamento que Ben irá observar com um interpretador que usa avaliação com ordem aplicativa? Qual é o comportamento que ele irá observar com um interpretador que usa avaliação com ordem normal? Explique a sua resposta.
