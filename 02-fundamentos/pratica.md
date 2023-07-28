---
# vim: set spell spelllang=pt_br sw=4:
title: Fundamentos - Prática
urlcolor: Blue
# TODO: adicionar as soluções
# TODO: pensar nos objetivos dessa atividade e verificar se os exercícios são adequados
# TODO: perdir explicitamente o uso de if, cond, and e or
---

1) Reveja o material da [introdução](https://malbarbo.pro.br/arquivos/2023/11917/01-introducao-notas-de-aula.pdf) e [fundamentos](https://malbarbo.pro.br/arquivos/2023/11917/02-fundamentos-notas-de-aula.pdf) (até a parte de condicional) e responda [esse](https://forms.gle/7iKbMkTS5UHNEYRv8) quiz (não vale nota).

1) Faça uma função chamada `area-retangulo` que recebe dois argumentos, a `largura` e a `altura` de um retângulo, e calcula a sua área. Confira na janela de interações se a função funciona de acordo com os exemplos a seguir

    ```{.scheme}
    > (area-retangulo 3 5)
    15
    > (area-retangulo 2.0 2.5)
    5.0
    ```


1) Faça uma função chamada `produto-anterior-posterior` que recebe um número inteiro `n` e calcula o produto de `n`, `n + 1` e `n - 1`. Confira na janela de interações se a função funciona de acordo com os exemplos a seguir

    ```{.scheme}
    > (produto-anterior-posterior 3)
    24
    > (produto-anterior-posterior 1)
    0
    > (produto-anterior-posterior -2)
    -6
    ```


1) Faça uma função chamada `aumenta` que recebe dois número positivos, um `valor` e uma `porcentagem`, e calcula o resultado de aumentar a `porcetagem` ao `valor`. Confira na janela de interações se a função funciona de acordo com os exemplos a seguir

    ```{.scheme}
    > (aumenta 100.0 3.0)
    103.0
    > (aumenta 20.0 50.0)
    30.0
    > (aumenta 10.0 80.0)
    18.0
    ```


1) Faça uma função chamada `zera-dezena-e-unidade` que recebe um número natural `n` e devolve um novo número que é como `n` mas tem o valor da dezena e unidade zero. Veja a função [quotient](https://docs.racket-lang.org/reference/generic-numbers.html#%28def.\_%28%28quote.\_~23~25kernel%29.\_quotient%29%29) Confira na janela de interações se a função funciona de acordo com os exemplos a seguir

    ```{.scheme}
    > (zera-dezena-e-unidade 19)
    0
    > (zera-dezena-e-unidade 341)
    300
    > (zera-dezena-e-unidade 5251)
    5200
    ```


1) Faça uma função chamada `par?` que recebe um número natural `n` e indica se `n` é par. Um número é par se o resto da divisão dele por 2 é igual a zero. Veja a função [remainder](https://docs.racket-lang.org/reference/generic-numbers.html#%28def.\_%28%28quote.\_~23~25kernel%29.\_remainder%29%29). Confira na janela de interações se a função funciona de acordo com os exemplos a seguir

    ```{.scheme}
    > (par? 3)
    #f
    > (par? 6)
    #t
    ```


1) Faça uma função chamada `exclamacao` que recebe dois argumento, uma string `frase` e um número natural `n`, e produz a mesma frase adicionando `n` pontos de exclamação no final da frase. Veja a documentação do tipo [string](https://docs.racket-lang.org/reference/strings.html) (funções `string-append` e `make-string`. Confira na janela de interações se a função funciona de acordo com os exemplos a seguir

    ```{.scheme}
    > (exclamacao "Nossa" 3)
    "Nossa!!!"
    > (exclamacao "Que legal" 1)
    "Que legal!"
    > (exclamacao "Nada" 0)
    "Nada"
    ```


1) Faça uma função chamada `censura` que recebe dois argumento, uma string `frase` e um número natural `n`, e produz uma nova frase trocando as as primeiras `n` letras da frase de entrada por `n` `"x"`. Veja a documentação do tipo [string](https://docs.racket-lang.org/reference/strings.html) (funções `string-append`, `substring` e `make-string`). Confira na janela de interações se a função funciona de acordo com os exemplos a seguir

    ```{.scheme}
    > (censura "droga de lanche!" 5)
    "xxxxx de lanche!"
    > (censura "ferrou geral!" 6)
    "xxxxxx geral!"
    ```


1) Faça uma função `maximo` que encontre o máximo entre dois números dados. Confira na janela de interações se a função funciona de acordo com os exemplos a seguir

    ```{.scheme}
    > (maximo 3 5)
    5
    > (maximo 8 4)
    8
    > (maximo 6 6)
    6
    ```


1) Faça uma função `maximo3` que encontre o máximo entre três números dados. Confira na janela de interações se a função funciona de acordo com os exemplos a seguir

    ```{.scheme}
    > (maximo3 8 5 2)
    8
    > (maximo3 4 6 1)
    6
    > (maximo3 6 6 7)
    7
    ```
