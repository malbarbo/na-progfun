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

@) Quando devemos utilizar funções anônimas?

@) Em que situações é útil criar funções que produzem funções? Dê um exemplo de uma situação diferente das vistas em aula.


# Praticando

@) Projete a função `duas_vezes` que receba como parâmetro uma função de um parâmetro e devolva uma função que aplique a função original duas vezes. Exemplo:

    ```gleam-repl
    > duas_vezes(fn(x) { x + 1 })(3)
    5
    ```

@) Redefina em termos da função `reduz_num`, feita no capítulo **Funções como valores: abstração**, as funções da lista de exercícios de números naturais que dependem de outros parâmetros além de $n$ (como criar uma lista com $n$ repetições de um valor ou calcular $a^n$). Por que essas funções não puderam ser redefinidas antes?

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

@) Em um painel de um aeroporto é necessário exibir uma lista de nomes de cidades. Para que os nomes sejam exibidos corretamente, todos devem ter a mesma quantidade de caracteres. Não é desejável remover caracteres de nenhum nome, então a alternativa é adicionar caracteres em branco no final dos nomes (se necessário), para que todos fiquem com a mesma quantidade de caracteres. Por exemplo, se os nomes são `"São Paulo"`, `"Maringá"`, e `"Londrina"`, os nomes devem ser ajustados para `"São Paulo"`, `"Maringá  "` e `"Londrina "`. Projete uma função que ajuste uma lista de nomes para que possam ser exibidos no painel.

@) Um professor de biologia quer montar uma equipe para participar de um projeto. Ele pretende chamar os alunos que ficaram com nota acima da média da turma, mas a turma é muito grande, e por isso não é possível fazer esse processo de forma manual. Você consegue ajudar o professor projetando uma função que indique o nome dos alunos que ficaram com nota maior do que a média da turma sabendo o nome e a nota de cada aluno?
