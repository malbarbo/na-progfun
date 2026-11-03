---
# vim: set spell spelllang=pt_br sw=4:
title: |
       | Programação Funcional
       | Funções como valores: açúcar sintático
urlcolor: Blue
license:
---

# Começando

@) Dê um exemplo de função anônima que pode ser escrita com fechamento abreviado e um exemplo de uma que não pode. Explique a diferença.


# Praticando

@) Defina uma função que receba como parâmetro um predicado (função de um argumento que devolve um valor booleano) e uma lista, e conte quantos elementos da lista satisfazem o predicado. Faça duas versões: uma usando `list.fold_right` e outra combinando `list.filter` com outra função, usando o operador `|>`. Quais as vantagens e desvantagens de cada versão? Exemplo:

    ```gleam-repl
    > conta([3, 1, 2, 4, 7], int.is_odd)
    3
    ```

@) Reescreva a função a seguir usando o operador `|>` e, onde for possível, fechamento abreviado ou nenhuma função anônima.

    ```gleam
    fn soma_quadrados_pares(lst: List(Int)) -> Int {
      list.fold_right(
        list.map(list.filter(lst, fn(x) { int.is_even(x) }), fn(x) { x * x }),
        0,
        fn(acc, x) { int.add(acc, x) },
      )
    }
    ```

@) Reescreva a função a seguir usando `use`{.gleam}.

    ```gleam
    fn media3(a: String, b: String, c: String) -> Result(Float, Nil) {
      result.try(float.parse(a), fn(x) {
        result.try(float.parse(b), fn(y) {
          result.try(float.parse(c), fn(z) { Ok({ x +. y +. z } /. 3.0) })
        })
      })
    }
    ```

@) Defina uma função que converta uma lista de strings em uma lista de números inteiros, devolvendo `Error(Nil)`{.gleam} se alguma string não puder ser convertida. Use `list.fold_right` com `use`{.gleam} e `result.try`. Exemplo:

    ```gleam-repl
    > strings_para_numeros(["10", "-1", "7"])
    Ok([10, -1, 7])
    > strings_para_numeros(["10", "a", "7"])
    Error(Nil)
    ```


# Resolvendo problemas

@) Um sítio de conteúdo pretende fazer uma série de postagens com as palavras/expressões mais comuns em diversos idiomas, incluindo também listas especializadas para determinadas áreas (como engenharia, culinária, etc). Para isso é necessário levantar um corpus (coleções de textos) para a postagem, e gerar listas de palavras/expressões, o que já foi feito. Agora é preciso projetar uma função que receba uma lista de palavras/expressões e um número $n$ e produza uma lista com as $n$ palavras/expressões mais frequentes, junto com a quantidade de ocorrências de cada uma, em ordem decrescente de frequência. O valor de $n$ pode variar, dependendo do corpus e da equipe de especialistas que vai usar a função.
