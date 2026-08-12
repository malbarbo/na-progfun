---
# vim: set spell spelllang=pt_br sw=4:
title: |
       | Programação Funcional
       | Fundamentos
urlcolor: Blue
license:
# TODO: exercícios de avaliação direta de expressões? prioridades?
# TODO: exercícios de estratégia de avaliação
---

# Começando

@) O que é um literal?

@) O que é uma função primitiva?

@) Escreva três expressões em Gleam, cada uma correspondente a um caso diferente da definição de expressão. Indique a qual caso cada uma corresponde.

@) O que significa avaliar uma expressão?

@) Qual é a regra de avaliação para uma chamada de função?

@) Qual é a regra de avaliação para uma expressão `case`{.gleam}?

@) Escreva uma definição de constante e uma definição de função em Gleam. O que cada uma delas acrescenta ao ambiente?

@) O que é uma função?

@) A ordem que as expressões em uma chamada de função são avaliadas pode alterar o valor da chamada da função? Explique.

@) Explique por que `&&`{.gleam} e `||`{.gleam} são formas especiais e não funções. Dê um exemplo de expressão cujo comportamento mudaria se elas fossem funções.

@) O que é uma definição com autorreferência? E um processo recursivo?


# Praticando


<!-- Operadores lógicos e prioridades -->

@) Determine, sem usar o computador, o valor de cada expressão a seguir. Depois crie um arquivo com as definições abaixo, carregue o arquivo na janela de interações e confira as respostas.

    ```gleam
    pub const x = 3
    pub const y = 4
    ```

    a) `x > y || x % 2 == 1`{.gleam}
    a) `!{ x > y }`{.gleam}
    a) `x > 0 && y / x > 1`{.gleam}
    a) `x + y * 2 > 10 && x != y`{.gleam}
    a) `x < y == True`{.gleam}


<!-- Funções diretas com números e strings -->

@) Faça uma função chamada `area_retangulo` que recebe dois argumentos, a `largura` e a `altura` de um retângulo, e calcula a sua área. Use o método de substituição para verificar se a função funciona corretamente de acordo com os exemplos a seguir. Confira as respostas na janela de interações.

    ```gleam-repl
    > area_retangulo(3.0, 5.0)
    15.0
    > area_retangulo(2.0, 2.5)
    5.0
    ```


@) Faça uma função chamada `produto_anterior_posterior` que recebe um número inteiro `n` e calcula o produto de `n`, `n + 1` e `n - 1`. Use o método de substituição para verificar se a função funciona corretamente de acordo com os exemplos a seguir. Confira as respostas na janela de interações.

    ```gleam-repl
    > produto_anterior_posterior(3)
    24
    > produto_anterior_posterior(1)
    0
    > produto_anterior_posterior(-2)
    -6
    ```


<!-- Predicados -->

@) Faça uma função chamada `eh_par` que recebe um número natural `n` e indica se `n` é par. Um número é par se o resto da divisão dele por 2 é igual a zero. Não use `case`{.gleam} e nem a função pré-definida [`int.is_even`{.gleam}](https://hexdocs.pm/gleam_stdlib/gleam/int.html#is_even). Use o método de substituição para verificar se a função funciona corretamente de acordo com os exemplos a seguir. Confira as respostas na janela de interações.

    ```gleam-repl
    > eh_par(3)
    False
    > eh_par(6)
    True
    ```


@) Faça uma função chamada `tem_tres_digitos` que recebe um número natural `n` e verifica se `n` tem exatamente 3 dígitos. Não use `case`{.gleam}. Use o método de substituição para verificar se a função funciona corretamente de acordo com os exemplos a seguir. Confira as respostas na janela de interações.

    ```gleam-repl
    > tem_tres_digitos(99)
    False
    > tem_tres_digitos(100)
    True
    > tem_tres_digitos(999)
    True
    > tem_tres_digitos(1000)
    False
    ```


@) Faça uma função chamada `entre` que recebe três inteiros, `a`, `x` e `b`, e determina se `x` está entre `a` e `b`, incluindo os extremos. Não use `case`{.gleam}. Use o método de substituição para verificar se a função funciona corretamente de acordo com os exemplos a seguir. Confira as respostas na janela de interações.

    ```gleam-repl
    > entre(2, 5, 8)
    True
    > entre(2, 2, 8)
    True
    > entre(2, 9, 8)
    False
    ```


<!-- Condicional -->

@) Faça uma função `maximo` que encontre o máximo entre dois inteiros. Não use a função [`int.max`{.gleam}](https://hexdocs.pm/gleam_stdlib/gleam/int.html#max). Use o método de substituição para verificar se a função funciona corretamente de acordo com os exemplos a seguir. Confira as respostas na janela de interações.

    ```gleam-repl
    > maximo(3, 5)
    5
    > maximo(8, 4)
    8
    > maximo(6, 6)
    6
    ```


@) Faça uma função chamada `ordem` que recebe três inteiros distintos, `a`, `b` e `c` e determina se a sequência `a, b, c` está em ordem crescente, decrescente ou não está em ordem. Use o método de substituição para verificar se a função funciona corretamente de acordo com os exemplos a seguir. Confira as respostas na janela de interações.

    ```gleam-repl
    > ordem(3, 8, 12)
    "crescente"
    > ordem(3, 1, 4)
    "sem ordem"
    > ordem(3, 1, 0)
    "decrescente"
    ```

# Avançando

<!-- Desafios -->

@) Faça uma função chamada `so_primeira_maiuscula` que recebe uma palavra não vazia (string) como parâmetro e crie uma nova string convertendo a primeira letra da palavra para maiúscula e o restante da palavra para minúscula. Use o método de substituição para verificar se a função funciona corretamente de acordo com os exemplos a seguir. Confira as respostas na janela de interações. Veja as funções [`string.slice`](https://hexdocs.pm/gleam_stdlib/gleam/string.html#slice), [`string.uppercase`](https://hexdocs.pm/gleam_stdlib/gleam/string.html#uppercase) e [`string.lowercase`](https://hexdocs.pm/gleam_stdlib/gleam/string.html#lowercase).

    ```gleam-repl
    > so_primeira_maiuscula("paula")
    "Paula"
    > so_primeira_maiuscula("ALFREDO")
    "Alfredo"
    ```

@) [sicp 1.4] O modelo de avaliação visto em sala permite que os operadores em chamadas de funções sejam expressões compostas. Use esta observação para descrever o comportamento do seguinte procedimento:

    ```gleam
    fn a_plus_abs_b(a, b) {
      case b > 0 {
        True -> int.add
        False -> int.subtract
      }(a, b)
    }
    ```

@) [sicp 1.5] Ben Bitdiddle inventou um método para determinar se um interpretador está usando avaliação com ordem aplicativa ou avaliação com ordem normal. Ele definiu os seguintes procedimentos:

    ```gleam
    fn p() {
      p()
    }

    fn teste(x, y) {
      case x == 0 {
        True -> 0
        False -> y
      }
    }
    ```

    Então avaliou a seguinte expressão

    ```gleam
    teste(0, p())
    ```

    Qual é o comportamento que Ben observará com um interpretador que usa avaliação com ordem aplicativa? Qual é o comportamento que ele observará com um interpretador que usa avaliação com ordem normal? Explique a sua resposta.
