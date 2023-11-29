---
# vim: set spell spelllang=pt_br sw=4:
title: Projeto de funções - Prática
urlcolor: Blue
---

@) Implemente a função de acordo com a especificação a seguir. Corrija a especificação se necessário.

    ```scheme
    ;; InteiroPositivo -> Boolean
    ;;
    ;; Produz #t se uma pessoa com idade id é isento da
    ;; tarifa de transporte público, isto é, tem menos
    ;; que 18 anos ou 65 ou mais. Produz #f caso contrário.

    (examples
     (check-equal? (isento-tarifa? 17) #t)
     (check-equal? (isento-tarifa? 18) #t)
     (check-equal? (isento-tarifa? 50) #f)
     (check-equal? (isento-tarifa? 65) #t)
     (check-equal? (isento-tarifa? 70) #t))

    (define (isento-tarifa? id)
      #f)
    ```

@) Implemente a função de acordo com a especificação a seguir. Corrija a especificação se necessário.

    ```scheme
    ;; Inteiro -> Inteiro
    ;;
    ;; Conta a quantidade de dígitos de n.
    ;; Se n é 0, então devolve zero.
    ;; Se n é menor que zero, então devolve a quantidade
    ;; de dígitos do valor absoluto de n.

    (examples
     (check-equal? (quantidade-digitos 121) 3)
     (check-equal? (quantidade-digitos 0) 1)
     (check-equal? (quantidade-digitos -1519) 4))

    (define (quantidade-digitos n)
      0)
    ```

@) Implemente a função de acordo com a especificação a seguir. Corrija a especificação se necessário.

    ```scheme
    ;; InteiroPositivo -> Boolean
    ;;
    ;; Produz #t se uma pessoa com a idade n é supercentenária,
    ;; isto é, tem 110 anos ou mais, #f caso contrário.

    (examples
     (check-equal? (supercentenario 101) #f)
     (check-equal? (supercentenario 110) #f)
     (check-equal? (supercentenario 112) #t))

    (define (supercentaniro n)
      #f)
    ```

@) Implemente a função de acordo com a especificação a seguir. Corrija a especificação se necessário.

    ```scheme
    ;; String -> String
    ;;
    ;; Transforma a data de entrada do formato "dia/mes/ano"
    ;; para o formato "ano/mes/dia".
    ;;
    ;; Requer que o dia e o mes tenha dois dígitos e que
    ;; o ano tenha quatro digitos.

    (examples
     (check-equal? (data-dma->data-amd "19/07/2023") "2023/07/19")
     (check-equal? (data-dma->data-amd "01/01/1980") "1980/01/01")
     (check-equal? (data-dma->data-amd "02/02/2002") "2002/02/20"))

    (define (data-dma->data-amd data)
      data)
    ```

@) Escreva a especificação para a seguinte implementação de função. Observe que a especificação sozinha deve ser suficiente para um programador fazer uma implementação.

    ```scheme
    (define (tamanho-nome nome)
      (cond
        [(<= (string-length nome) 4) "curto"]
        [(<= (string-length nome) 10) "médio"]
        [else "longo"]))
    ```

@) Escreva a especificação para a seguinte implementação de função. Observe que a especificação sozinha deve ser suficiente para um desenvolvedor fazer uma implementação.

    ```scheme
    (define (qualificacao num-questoes num-acertos faltas)
      (define aproveitamento (/ num-acertos num-questoes))
      (cond
        [(or (< aproveitamento 0.3) (> faltas 0.25)) "reprovado"]
        [(< aproveitamento 0.6) "nova-tentativa"]
        [else "aprovado"]))
    ```


@) Uma polegada é um medida de comprimento utilizado no sistema imperial e corresponde a 2,54cm.

    a. Projete uma função que converta uma medida em centímetros para polegadas.

    b. Projete uma função que converta uma medida em polegadas para centímetros.

@) Projete uma função que recebe dois número positivos, um `valor` e uma `porcentagem`, e calcula o resultado de aumentar a `porcentagem` ao `valor`.

@) Faça uma função chamada `zera-dezena-e-unidade` que recebe um número natural `n` e devolve um novo número que é como `n` mas tem o valor da dezena e unidade zero. Veja a função [quotient](https://docs.racket-lang.org/reference/generic-numbers.html#%28def.\_%28%28quote.\_~23~25kernel%29.\_quotient%29%29) Confira na janela de interações se a função funciona de acordo com os exemplos a seguir

    ```{.scheme}
    > (zera-dezena-e-unidade 19)
    0
    > (zera-dezena-e-unidade 341)
    300
    > (zera-dezena-e-unidade 5251)
    5200
    ```

@) Faça uma função chamada `censura` que recebe dois argumento, uma string `frase` e um número natural `n`, e produz uma nova frase trocando as as primeiras `n` letras da frase de entrada por `n` `"x"`. Veja a documentação do tipo [string](https://docs.racket-lang.org/reference/strings.html) (funções `string-append`, `substring` e `make-string`). Confira na janela de interações se a função funciona de acordo com os exemplos a seguir

    ```{.scheme}
    > (censura "droga de lanche!" 5)
    "xxxxx de lanche!"
    > (censura "ferrou geral!" 6)
    "xxxxxx geral!"
    ```

@) Faça uma função chamada `traco-meio?` que recebe uma string `s` e verifica se o caractere no meio de `s` é `"-"`. Não use `if`{.scheme} nem `cond`{.scheme}. Confira na janela de interações se a função funciona de acordo com os exemplos a seguir

    ```{.scheme}
    > (traco-meio? "lero-lero")
    #t
    > (traco-meio? "quase-meio")
    #f
    > (traco-meio? "-")
    #t
    ```


@) Faça uma função `maximo3` que encontre o máximo entre três números dados. Confira na janela de interações se a função funciona de acordo com os exemplos a seguir

    ```{.scheme}
    > (maximo3 8 5 2)
    8
    > (maximo3 4 6 1)
    6
    > (maximo3 6 6 7)
    7
    ```

@) Faça uma função chamada `adiciona-ponto` que recebe um string `frase` e adiciona um ponto final na `frase` se ela ainda não tiver um. Confira na janela de interações se a função funciona de acordo com os exemplos a seguir

    ```{.scheme}
    > (adiciona-ponto "Vou contar")
    "Vou contar."
    > (adiciona-ponto "Corri.")
    "Corri."
    ```
