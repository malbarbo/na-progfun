---
# vim: set spell spelllang=pt_br sw=4:
title: Projeto de funções - Problemas
urlcolor: Black
# TODO: trocar ab->string por palavra-duplicada
---

#. Implemente a função de acordo com a especificação a seguir. Corrija a especificação se necessário.

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

#. Implemente a função de acordo com a especificação a seguir. Corrija a especificação se necessário.

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

#. Escreva a especificação para a seguinte implementação de função. Observe que a especificação sozinha deve ser suficiente para um programador fazer uma implementação.

    ```scheme
    (define (tamanho-nome nome)
      (cond
        [(<= (string-length nome) 4) "curto"]
        [(<= (string-length nome) 10) "médio"]
        [else "longo"]))
    ```

#. Escreva a especificação para a seguinte implementação de função. Observe que a especificação sozinha deve ser suficiente para um programador fazer uma implementação.

    ```scheme
    (define (ab->number s)
      (string->number
       (string-replace (string-replace s "a" "0" ) "b" "1")
       2))
    ```

#. Uma polegada é um medida de comprimento utilizado no sistema imperial e corresponde a 2,54cm.

    a. Projete uma função que converta uma medida em centímetros para polegadas.

    b. Projete uma função que converta uma medida em polegadas para centímetros.

#. Cada cidadão de um país, cuja moeda chama dinheiro, tem que pagar imposto sobre a sua renda. Cidadãos que recebem até 1000 dinheiros pagam 5% de imposto. Cidadãos que recebem entre 1000 e 5000 dinheiros pagam 5% de imposto sobre 1000 dinheiros e 10% sobre o que passar de 1000. Cidadãos que recebem mais do 5000 dinheiros pagam 5% de imposto sobre 1000 dinheiros, 10% de imposto sobre 4000 dinheiros e 20% sobre o que passar de 5000. Projete uma função que calcule o imposto que um cidadão deve pagar dado a sua renda.

#. Uma palavra duplicada é formada pela ocorrência de duas partes iguais, separadas ou não por hífen. Por exemplo, as palavras xixi, mimi, lero-lero e mata-mata são palavras duplicadas. Projete uma função que verifique se uma palavra é duplicada. (Veja a função [`substring`](https://docs.racket-lang.org/reference/strings.html#%28def.\_%28%28quote.\_~23~25kernel%29.\_substring%29%29)).

#. Um construtor precisa calcular a quantidade de azulejos necessários pra azulejar uma determinada parede. Cada azulejo é quadrado e tem 20cm de lado. Ajude o construtor e defina uma função que receba como entrada o comprimento e a altura em metros de uma parede e calcule a quantidade de azulejos inteiros necessários para azulejar a parede. Considere que o construtor nunca perde um azulejo e que recortes de azulejos não são reaproveitados.

#. (Desafio) Um número inteiro positivo é palíndromo se quando lido da direita para a esquerda ou da esquerda para a direita é idêntico. Ex: 9119, 1221, 5665, 7337. Projete uma função que verifique se um dado número inteiro de 4 dígitos é palíndromo, considere que o valor de entrada é o próprio número e não os quatro dígitos que compõem o número. É possível modificar a sua função de maneira que ela funcione para qualquer número de entrada e não apenas para números de 4 dígitos?

#. Faça a execução passo a passo das funções definidas nos exercícios anteriores para alguns exemplos. Para isto você deve criar um novo arquivo, mudar a linguagem para "Beginning Student" e copiar o código da função e da chamada de exemplo.
