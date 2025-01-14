---
# vim: set spell spelllang=pt_br sw=4:
# TODO: adicionar exemplos para a chamada da função com acumuladores
# TODO: usar um exemplo "mais simples" para introduzir o conceito (o exemplo da soma?)
# TODO: apresentar uma forma diferente de projeto (como em fundamentos de algoritmos)? Seria necessário deixar de lado a ideia de que acumulador é algo se faz depois?
# TODO: ao invés de apresentar foldl e foldr separados, unir os dois assuntos em "percurso de listas"?
# TODO: adicionar exemplo com mais de um acumulador
# TODO: adicionar um exemplo que a resposta não é o acumulador
title: Acumuladores
---

Introdução
==========

## Falta de contexto na recursão

Até agora não nos preocupamos com o contexto do uso quando criamos funções recursivas, \pause não importa se é a primeira vez que a função está sendo chamada ou se é a 100ª. \pause

Este princípio de independência do contexto facilita a escrita de funções recursivas, mas pode gerar problemas em algumas situações. \pause

Vamos ver um exemplo.


## Exemplo

Dado uma lista de distâncias relativas entre pontos em uma linha, começando da origem, defina uma função que calcule a distância absoluta a partir da origem.


## Exemplo

<div class="columns">
<div class="column" width="52%">
\scriptsize

```gleam
/// Converte a lista *lst* de distâncias relativas
/// para uma lista de distâncias absolutas. O
/// primeiro item da lista representa a distância
/// da origem.
pub fn relativa_absoluta(
  lst: List(Int)
) -> List(Int) {
  todo
}

pub fn relativa_absoluta_examples() {
  check.eq(
    relativa_absoluta([50, 40, 70, 30, 30]),
    [50, 90, 160, 190, 220]
  )
}
```

\pause
</div>
<div class="column" width="44%">

Como resolvemos este problema? \pause

Começando com o modelo! \pause

\ \

\scriptsize

```gleam
fn relativa_absoluta(lst) {
  case {
    [] -> todo
    [primeiro, ..resto] -> {
      todo
      primeiro
      relativa_absoluta(resto)
    }
  }
}
```

</div>
</div>


## Exemplo

\small

Para a entrada `[50, 40, 70, 30, 30]`{.gleam} a função deve produzir como saída `[50, 90, 160, 190, 220]`{.gleam}. \pause

Como combinar `primeiro`{.gleam} -- `50`{.gleam} -- com `relativa_absoluta(resto)`{.gleam} -- `[40, 110, 140, 170]`{.gleam} -- para obter a resposta para `lst`{.gleam}? \pause

```gleam
[50, 40, 70, 30, 30]   ->   [50, 90, 160, 190, 220]

                            50  [40, 110, 140, 170]
                             |  |
                      primeiro  relativa_absoluta(resto)
```

\pause

Somando `50`{.gleam} a cada elemento de `[40, 110, 140, 170]`{.gleam} \pause

```gleam
[primeiro,
 ..list.map(relativa_absoluta(resto), int.add(_, primeiro))]
```


## Exemplo

<div class="columns">
<div class="column" width="54%">

\scriptsize

```gleam
pub fn relativa_absoluta(lst) {
  case lst {
    [] -> []
    [primeiro, ..resto] -> [
      primeiro,
      ..list.map(
          relativa_absoluta(resto),
          int.add(_, primeiro),
      )
    ]
  }
}
```

</div>
<div class="column" width="44%">

Qual é o problema dessa função? \pause

Ela realiza muito trabalho! O tempo de execução é $\Theta(n^2)$. \pause

Podemos melhorar? \pause Sim! \pause

Como resolveríamos o problema manualmente? \pause

Somando a distância relativa do ponto com a distância absoluta do ponto anterior. \pause

Vamos tentar definir uma função mais parecida com este método manual.

</div>
</div>


## Exemplo

<div class="columns">
<div class="column" width="48%">

Como queremos que a função funcione?

\scriptsize

```gleam
[50, 40, 70, 30, 30] -> [50, 90, 160, 190, 220]
```

\pause

```gleam
[50,
 ..relativa_absoluta([40, 70, 30, 30])]
```

\pause

```gleam

[50, 90,
 ..relativa_absoluta([70, 30, 30])]
```

\pause

```gleam

[50, 90, 160,
 ..relativa_absoluta([30, 30])]
```

\pause

```gleam

...

[50, 90, 160, 190, 220,
 ..relativa_absoluta([])]
```

\pause

</div>
<div class="column" width="48%">

É possível implementar a função para que ela funcione _exatamente_ dessa forma? \pause Não! \pause Por que não? \pause Não sabemos qual é a distância que precisa ser somada no primeiro elemento, ou seja, não temos um contexto da chamada da função. \pause

Como resolver esse problema, isto é, como acessar a distância absoluta anterior para calcular a distância atual? \pause Adicionando um novo parâmetro para a distância absoluta anterior, ou seja, um contexto para a chamada da função.
</div>
</div>


## Exemplo

<div class="columns">
<div class="column" width="48%">

Como queremos que a função funcione?

\scriptsize

```gleam
[50, 40, 70, 30, 30] -> [50, 90, 160, 190, 220]
```

```gleam
[50,
 ..relativa_absoluta([40, 70, 30, 30])]
```

```gleam

[50, 90,
 ..relativa_absoluta([70, 30, 30])]
```

```gleam

[50, 90, 160,
 ..relativa_absoluta([30, 30])]
```

```gleam

...

[50, 90, 160, 190, 220,
 ..relativa_absoluta([])]
```

</div>
<div class="column" width="48%">
\scriptsize

```gleam
relativa_absoluta([50, 40, 70, 30, 30], 0)
```

\pause

```gleam
[50,
 ..relativa_absoluta([40, 70, 30, 30], 50)]
```

\pause

```gleam

[50, 90,
 ..relativa_absoluta([70, 30, 30], 90)]
```

\pause

```gleam

[50, 90, 160,
 ..relativa_absoluta([30, 30], 160)]
```

\pause

```gleam

...

[50, 90, 160, 190, 220,
 ..relativa_absoluta([], 220)]
```

</div>
</div>


## Exemplo

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
fn relativa_absoluta(
  lst: List(Int),
  dist: Int,
) -> List(Int) {
  // dist é a distância absoluta até o ponto
  // anterior ao primeiro de lst.
  case lst {
    [] -> []
    [primeiro, ..resto] -> [
      primeiro + dist,
      ..relativa_absoluta(resto,
                          primeiro + dist)
    ]
  }
}
```

\pause

\normalsize

Qual o problema com essa função? \pause

Ela precisa de um parâmetro extra, que não faz parte do problema. \pause

</div>
<div class="column" width="48%">

Vamos separar na função principal e em uma função com acumulador. \pause

\scriptsize

```gleam

fn relativa_absoluta(lst) {
  relativa_absoluta_loop(lst, 0)
}
fn relativa_absoluta_loop(
  lst: List(Int),
  dist: Int,
) -> List(Int) {
  case lst {
    [] -> []
    [primeiro, ..resto] -> [
      primeiro + dist,
      ..relativa_para_absoluta_loop(resto,
                                    primeiro + dist)
    ]
  }
}
```


</div>
</div>


## Falta de contexto na recursão

No exemplo `relativa_absoluta`{.gleam} vimos que a falta de contexto durante a recursão tornou a função mais complicada e mais lenta do que o necessário. \pause

Agora veremos um exemplo em que a falta de contexto faz uma função usar mais memória do que o necessário.


Processos iterativos e recursivos
=================================


## Processos iterativos e recursivos

Considere as seguintes implementações para a função que soma dois números naturais.

<div class="columns">
<div class="column" width="48%">
\small

```gleam
fn soma(a: Int, b: Int) -> Int {
  case b {
    0 -> a
    _ -> 1 + soma(a, b - 1)
  }
}
```

</div>
<div class="column" width="48%">

\small

```gleam
fn soma_alt(a: Int, b: Int) -> Int {
  case b {
    0 -> a
    _ -> soma(a + 1, b - 1)
  }
}
```

</div>
</div>

\normalsize

\ \

Qual é o processo gerado quando cada função é avaliada com os parâmetros `4`{.gleam} e `3`{.gleam}?


## Processos iterativos e recursivos

<div class="columns">
<div class="column" width="40%">
\small

```gleam
fn soma(a: Int, b: Int) -> Int {
  case b {
    0 -> a
    _ -> 1 + soma(a, b - 1)
  }
}
```

\pause

</div>
<div class="column" width="10%">
</div>
<div class="column" width="50%">
\small

`soma(4, 3)`{.gleam} \pause \newline
`1 + soma(4, 2)`{.gleam} \pause \newline
`1 + {1 + soma(4, 1)}`{.gleam} \pause \newline
`1 + {1 + {1 + soma(4, 0)}}`{.gleam} \pause \newline
`1 + {1 + {1 + 4}}`{.gleam} \pause \newline
`1 + {1 + 5}`{.gleam} \pause \newline
`1 + 6`{.gleam} \pause \newline
`7`{.gleam} \pause
</div>
</div>

\ \

Este é um **processo recursivo**. Ele é caracterizado por uma sequência de operações adiadas e tem um padrão de "cresce e diminui".


## Processos iterativos e recursivos

<div class="columns">
<div class="column" width="48%">
\small

```gleam
fn soma(a: Int, b: Int) -> Int {
  case b {
    0 -> a
    _ -> 1 + soma(a, b - 1)
  }
}
```

\pause

</div>
<div class="column" width="48%">
\small

`soma_alt(4, 3)`{.gleam} \pause \newline
`soma_alt(5, 2)`{.gleam} \pause \newline
`soma_alt(6, 1)`{.gleam} \pause \newline
`soma_alt(7, 0)`{.gleam} \pause \newline
`7`{.gleam} \pause

</div>
</div>

\ \

Este é um **processo iterativo**. Nele o "espaço" necessário para fazer a substituição não depende do tamanho da entrada.


## Processos iterativos e recursivos

Na avaliação da expressão `soma_alt(4, 3)`{.gleam} no exemplo anterior, o valor de `a`{.gleam} foi usado como um acumulador, armazenando a soma parcial. \pause

O uso de acumulador neste problema reduziu o uso de memória.



Recursão em cauda
=================


## Recursão em cauda

Uma **chamada em cauda** é a chamada de uma função que acontece como última operação dentro de uma função. \pause

Uma **função recursiva em cauda** é aquela em que todas as chamadas recursivas são em cauda.


## Recursão em cauda

A forma de criar processos iterativos em linguagens funcionais é utilizando recursão em cauda. \pause

Os compiladores/interpretadores de linguagens funcionais otimizam as recursões em cauda de maneira que não é necessário manter a pilha das chamadas recursivas, o que torna a recursão tão eficiente quanto um laço em uma linguagem imperativa. Esta técnica é chamada de **eliminação da chamada em cauda**.



Projetando funções com acumuladores
===================================

## Projetando funções com acumuladores

Usar acumuladores é algo que fazemos **depois** que definimos a função e não antes. \pause

As etapas para projetar funções com acumuladores são \pause

- Identificar que a função se beneficia ou precisa de um acumulador \pause

    - Torna a função mais simples \pause
    - Diminui o tempo de execução \pause
    - Diminui o consumo de memória \pause

- Entender o que o acumulador significa e determinar \pause

    - A inicialização \pause
    - A atualização \pause

- Determinar o resultado da função a partir do acumulador


## Projetando funções com acumuladores

Vamos reescrever diversas funções utilizando acumuladores.


## Exemplo - tamanho

<div class="columns">
<div class="column" width="48%">

\scriptsize

```gleam
/// Conta a quantidade de elementos de *lst*.
fn tamanho(lst: List(a)) -> Int {
  case lst {
    [] -> 0
    [_, ..resto] -> 1 + tamanho(resto)
  }
}

fn tamanho_examples() {
  check.eq(tamanho([]), 0)
  check.eq(tamanho([4]), 1)
  check.eq(tamanho([7, 1]), 2)
}
```

\pause

</div>
<div class="column" width="48%">

Existe algum benefício em utilizar acumulador? \pause

Como o tamanho da resposta não depende do tamanho da entrada, esta função está usando mais memória do que é necessário, portanto ela pode beneficiar-se do uso de acumulador. \pause

Qual o significado do acumulador? \pause A quantidade de elementos já "vistos". \pause

Qual é o valor inicial do acumulador? \pause `0`{.gleam}. \pause

Como atualizar o acumulador? \pause Somando 1. \pause

Qual é a resposta da função? \pause O valor do acumulador.

</div>
</div>


## Exemplo - tamanho

\scriptsize

```gleam
/// Conta a quantidade de elementos de *lst*.
fn tamanho(lst: List(a)) -> Int {
  tamanho_loop(lst, 0)
}

fn tamanho_loop(lst: List(a), acc: Int) -> Int {
  case lst {
    [] -> acc
    [_, ..resto] -> tamanho_loop(resto, acc + 1)
  }
}
```


## Exemplo - soma

<div class="columns">
<div class="column" width="48%">

\scriptsize

```gleam
/// Soma os elementos de *lst*.
fn soma(lst: List(Int)) -> Int {
  case lst {
    [] -> 0
    [p, ..r] -> p + soma(r)
  }
}

fn tamanho_examples() {
  check.eq(soma([]), 0)
  check.eq(soma([4]), 4)
  check.eq(soma([7, 1]), 8)
}
```

\pause

</div>
<div class="column" width="48%">

Existe algum benefício em utilizar acumulador? \pause

Como o tamanho da resposta não depende do tamanho da entrada, esta função está usando mais memória do que é necessário, portanto ela pode beneficiar-se do uso de acumulador. \pause

Qual o significado do acumulador? \pause A soma dos elementos já "vistos". \pause

Qual é o valor inicial do acumulador? \pause `0`{.gleam}. \pause

Como atualizar o acumulador? \pause Somando o primeiro da lista de entrada. \pause

Qual é a resposta da função? \pause O valor do acumulador.

</div>
</div>



## Exemplo - soma

\scriptsize

```gleam
/// Soma os elementos de *lst*.
fn soma(lst: List(Int)) -> Int {
  soma_loop(lst, 0)
}

fn soma_loop(lst: List(Int), acc: Int) -> Int {
  case lst {
    [] -> acc
    [p, ..r] -> soma_loop(r, acc + p)
  }
}
```


## Exemplo - inverte

<div class="columns">
<div class="column" width="48%">

\scriptsize

```gleam
/// Inverte os elementos de *lst*.
fn inverte(lst: List(a)) -> List(a) {
  case lst {
    [] -> []
    [p, ..r] -> adiciona_fim(inverte(r), p)
  }
}

fn inverte_examples() {
  check.eq(inverte([]), [])
  check.eq(inverte([7, 1]), [1, 7])
}
```

\pause

</div>
<div class="column" width="48%">

Existe algum benefício em utilizar acumulador? \pause

Neste caso a função é mais complicada do que o necessário. Isto porque o resultado da chamada recursiva é processada por outra função recursiva (`list.append`{.gleam}). \pause Além disso, o tempo de execução desta função é $\Theta(n^2)$, o que intuitivamente é muito para inverter uma lista. \pause

Qual o significado do acumulador? \pause Os elementos que já foram visitados em ordem reversa. \pause

Qual é o valor inicial do acumulador? \pause `[]`{.gleam}. \pause

Como atualizar o acumulador? \pause Colocando o primeiro da entrada como primeiro do acumulador. \pause

Qual é a resposta da função? \pause O valor do acumulador.

</div>
</div>


## Exemplo - inverte

\scriptsize

```gleam
/// Inverte os elementos de *lst*.
fn inverte(lst: List(a)) -> List(a) {
  inverte_loop(lst, [])
}

fn inverte_loop(lst: List(a), acc: List(a)) -> List(a) {
  case lst {
    [] -> acc
    [p, ..r] -> inverte_loop(r, [p, ..acc])
  }
}
```


Função `fold` (left)
============

## Função `fold` (left)

Vamos observar as semelhanças das funções `tamanho`{.gleam}, `soma`{.gleam} e `inverte`{.gleam}.


## Função `fold` (left)



## Função `fold` (left)



## Função `fold` (left)



## Função `fold` (left)

Vamos criar uma função chamada `reduz_acc`{.gleam} (pré-definida em Gleam com o nome `list.fold`{.gleam}) que abstrai este comportamento.


## Função `reduz-acc` / `fold`


## Função `fold` (left)

Redefinimos as funções em termos de `reduz_acc`


`fold_right` vs `fold`
==============

## `fold_right` vs `fold`

`fold_right` e `fold` produzem o mesmo resultado se a função `f` for associativa. \pause

Quando possível, utilize a função `fold`, pois ela pode utilizar menos memória. \pause

Não tenha receio de utilizar a função `fold_right`, muitas funções ficam mais complicadas, ou não podem ser escritas em termos de `foldl`, como por exemplo, `map` e `filter`.



Referências
===========

## Referências

Básicas

- Capítulos [31](https://htdp.org/2022-8-7/Book/part_six.html#%28part._ch~3aaccumulator-samples%29) e [32](https://htdp.org/2022-8-7/Book/part_six.html#%28part._sec~3adesign-accu%29) do livro [HTDP](http://htdp.org).

- Seção [1.2](https://mitpress.mit.edu/sicp/full-text/book/book-Z-H-11.html#%_sec_1.2) do livro [SICP](https://mitpress.mit.edu/sicp/).
