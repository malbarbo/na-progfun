---
# vim: set spell spelllang=pt_br sw=4:
title: |
       | Programação Funcional
       | Funções como valores
urlcolor: Blue
license:
# TODO: adicionar exercícios diretos para treinar let e funções anônimas?
---

# Começando

@) O que significa dizer que funções são entidades de primeira classe?

@) O que é uma função de alta ordem?

@) Quando podemos utilizar as funções `map`, `filter` e `foldr`?

@) Qual é a estratégia foi discutida para projetar funções que recebem funções como parâmetro?

@) O que é um fechamento?

@) Quando devemos utilizar funções anônimas?

@) Qual é o uso mais comum para funções que produzem funções?


# Praticando

@) Analise os exemplos e exercícios de listas e redefina as funções (que forem possíveis) utilizando as funções `map`, `filter` e `foldr` (diretamente ou com uma combinação dessas funções). As novas funções ficaram mais simples?

@) Defina uma função que receba como parâmetro um predicado (função de um argumento que retorna um valor booleano) e uma lista, e conte quantos elementos da lista satisfazem o predicado. Exemplo

    ```scheme
    > (conta positive? (list 1 -1 2 3 -2 5))
    4
    ```

@) Projete a função `duas-vezes` que receba como parâmetro uma função de um parâmetro e retorne uma função que aplique a função original duas vezes. Exemplo

    ```scheme
    > ((duas-vezes add1) 3)
    5
    > ((duas-vezes (curry * 2)) 5)
    20
    ```

@) Vimos como usar a função pré-definida `map` do Racket utilizando apenas uma lista, mas de fato, a função `map` aceita como parâmetro uma função de aridade $n$ e $n$ listas do mesmo tamanho. Nessa forma geral, a função `map` aplica a função parâmetro a todos os primeiros elementos das listas, depois aplica a função a todos os segundos elementos das listas e assim por diante, retornando a lista de resultados. Os exemplos a seguir mostrar esse funcionamento

    ```scheme
    > (map + (list 1 2 3) (list 4 5 6) (list 7 8 9))
    '(12 15 18)
    > (map list (list 1 2 3) (list 4 5 6))
    '((1 4) (2 5) (3 6))
    ```

    Projete uma versão restrita da função `map`, chamada `map2`, que funciona para uma duas listas, como no exemplo a seguir

    ```scheme
    > (map2 * (list 1 2 3) (list 4 5 6))
    '(4 10 18)
    > (map2 list (list 1 2 3) (list 4 5 6))
    '((1 4) (2 5) (3 6))
    ```


@) Analise os exemplos e exercícios de números naturais e defina uma função `reduz-num` (semelhante a função `reduz` feita em sala) que abstraia o comportamento do modelo para funções com números naturais. Redefina as funções (que forem possíveis) em termos de `reduz-num`. As novas funções ficaram mais simples?

@) (Desafio)^[[Structure and Interpretation of Computer Programs](https://mitpress.mit.edu/sicp/)] A seguir é apresentado uma representação procedural para um par. Para esta representação, verifique que `(first (cons x y))` produz `x` para quaisquer objetos `x` e `y`.

    ```
    (define (cons x y)
      (λ (m) (m x y)))

    (define (first z)
      (z (λ (p q) p)))
    ```

    Qual é a definição correspondente de `rest`{.scheme}? (Dica: para verificar que isto funciona, faça uso do modelo de substituição).


# Resolvendo problemas

@) Em um painel de um aeroporto é necessário exibir uma lista de nomes de cidades. Para que os nomes sejam exibidos corretamente, todos devem ter a mesma quantidade de caracteres. Não é desejável remover caracteres de nenhum nome, então a alternativa é adicionar caracteres em branco no final dos nomes (se necessário), para que todos fiquem com a mesma quantidade de caracteres. Por exemplo, se os nomes são `"São Paulo"`, `"Maringá"`, e `"Londrina"`, os nomes devem ser ajustados para `"São Paulo"`, `"Maringá  "` e `"Londrina "`. Projete uma função que ajuste uma lista de nomes para que possam ser exibidos no painel.

@) Um professor de biologia quer montar uma equipe para participar de um projeto. Ele pretende chamar os alunos que ficaram com nota acima da média da turma, mas a turma é muito grande, e por isso não é possível fazer esse processo de forma manual. Você consegue ajudar o professor projetando uma função que indique o nome dos alunos que ficaram com nota maior do que a média da turma sabendo o nome e a nota de cada aluno?

@) Um sítio de conteúdo pretende fazer uma série de postagens com as palavras/expressões mais comuns em diversos idiomas, incluindo também listas especializadas para determinadas áreas (como engenharia, culinária, etc). Para isso é necessário levantar um corpus (coleções de textos) para a postagem, e gerar listas de palavras/expressões, o que já foi feito. Agora é preciso projetar uma função que analise ima lista e gere uma tabela com as palavras/expressões mais frequentes. A quantidade de itens na tabela pode variar, dependendo do corpus e da equipe de especialistas que vai usar a função.