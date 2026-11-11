---
# vim: set spell spelllang=pt_br sw=4:
title: |
       | Programação Funcional
       | Funções como valores: fechamentos
urlcolor: Blue
license:
---

# Começando

@) O que é uma variável livre?

@) O que é um fechamento?

@) Dê um exemplo de uma situação em que é mais adequado usar uma função anônima e um exemplo de uma situação em que é mais adequado definir uma função com nome. Justifique.

@) Em que situações é útil criar funções que produzem funções? Dê um exemplo de uma situação diferente das vistas em aula.


# Praticando

@) Projete a função `duas_vezes` que receba como parâmetro uma função de um parâmetro e devolva uma função que aplique a função original duas vezes. Exemplo:

    ```gleam-repl
    > duas_vezes(fn(x) { x + 1 })(3)
    5
    ```

@) Projete a função `compoe` que receba como parâmetros duas funções `f` e `g`, de um parâmetro cada, e devolva a função composta de `f` com `g`, isto é, a função que aplica `g` ao seu argumento e depois aplica `f` ao resultado. Redefina `duas_vezes` em termos de `compoe`. Exemplo:

    ```gleam-repl
    > compoe(int.is_odd, string.length)("abc")
    True
    > list.filter(["casa", "oi", "abc"], compoe(int.is_odd, string.length))
    ["abc"]
    ```

@) Projete a função `inverte` que receba como parâmetro uma função de comparação e devolva uma função de comparação que produz a ordem inversa da original. Use `inverte` e a função `compara_por`, vista em sala, para ordenar uma lista de strings da mais longa para a mais curta. Exemplo:

    ```gleam-repl
    > list.sort([3, 1, 2], inverte(int.compare))
    [3, 2, 1]
    ```

    Observação: a biblioteca padrão do Gleam tem essa função, chamada `order.reverse`{.gleam}.

@) Redefina em termos da função `reduz_num`, feita na lista de exercícios do capítulo **Funções como valores: abstração**, as funções da lista de exercícios de números naturais que dependem de outros parâmetros além de $n$ (como criar uma lista com $n$ repetições de um valor ou calcular $a^n$). Por que essas funções não puderam ser redefinidas antes?

<!--
@) (Desafio)^[[Structure and Interpretation of Computer Programs](https://mitpress.mit.edu/sicp/)] A seguir é apresentado uma representação procedural para um par. Para esta representação, verifique que `(first (cons x y))` produz `x` para quaisquer objetos `x` e `y`.

    ```
    (define (cons x y)
      (λ (m) (m x y)))

    (define (first z)
      (z (λ (p q) p)))
    ```

    Qual é a definição correspondente de `rest`{.scheme}? (Dica: para verificar que isto funciona, faça uso do modelo de substituição).
-->

# Resolvendo problemas

@) Em um painel de um aeroporto é necessário exibir uma lista de nomes de cidades. Para que os nomes sejam exibidos corretamente, todos devem ter a mesma quantidade de caracteres. Não é desejável remover caracteres de nenhum nome, então a alternativa é adicionar caracteres em branco no final dos nomes (se necessário), para que todos fiquem com a mesma quantidade de caracteres. Por exemplo, se os nomes são `"São Paulo"`, `"Maringá"` e `"Londrina"`, os nomes devem ser ajustados para `"São Paulo"`, `"Maringá  "` e `"Londrina "`. Projete uma função que ajuste uma lista de nomes para que possam ser exibidos no painel.

@) Um professor de biologia quer montar uma equipe para participar de um projeto. Ele pretende chamar os alunos que ficaram com nota acima da média da turma, mas a turma é muito grande, e por isso não é possível fazer esse processo de forma manual. Você consegue ajudar o professor projetando uma função que indique o nome dos alunos que ficaram com nota maior do que a média da turma, sabendo o nome e a nota de cada aluno?
