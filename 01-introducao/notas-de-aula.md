---
# vim: set spell spelllang=pt_br sw=4:
title: Programação funcional
---

O quê é?
========

## O quê é?

O que é programação imperativa? \pause

- Um paradigma de programação onde os programas são descritos com sentenças que modificam o estado do programa. \pause

O que é programação funcional? \pause

- Um paradigma de programação onde os programas são descritos com aplicação e composição de funções. \pause

- Evita mudança de estado. \pause

- Evita efeitos colaterais.


Por quê?
========

## Por quê?

Um paradigma (linguagem) de programação é uma ferramenta. \pause

Conhecer várias ferramentas permite utilizar a mais adequada para cada problema. \pause

Compartilhamento de dados junto com mudança de estado é difícil!


## Mudança de estado

<div class="columns">
<div class="column" width="50%">
Qual o valor de `lst`?

```python
>>> lst = [0] * 3
>>> lst
[0, 0, 0]
>>> lst[1] = 10
>>> lst
```

\pause

```python
[0, 10, 0]
```

\pause

</div>
<div class="column" width="50%">
Qual o valor de `lst`?

```python
>>> lst = [[]] * 3
>>> lst
[[], [], []]
>>> lst[1].append(2)
>>> lst
```

\pause

```python
[[2], [2], [2]]
```

</div>
</div>


## Mudança de estado

<div class="columns">
<div class="column" width="50%">

```python
def adiciona_todos(
        dest: list[int],
        fonte: list[int]):
    '''
    Adiciona todos os elementos
    de *fonte* no final
    de *dest*.
    '''
    for x in fonte:
        dest.append(x)
```

\pause

</div>
<div class="column" width="50%">

Qual o valor de `lst`?

```python
>>> lst = [4, 3, 1]
>>> adiciona_todos(lst, [6, 2])
>>> lst
```

\pause

```python
[4, 3, 1, 6, 2]
```

\pause

```python
>>> adiciona_todos(lst, lst)
>>> lst
```

\pause

O código entra em loop!

</div>
</div>


## Mudança de estado

\small

```python
def soma_indices(lst: list[int],
                 a: int,
                 b: int):
    return indice(lst, b) + indice(lst, a)


def soma_indices(lst: list[int],
                 a: int,
                 b: int):
    return indice(lst, a) + indice(lst, b)
```

\pause

\normalsize

Essa duas definições são equivalentes? \pause Depende da definição de `indice`!


## Pensar localmente

O uso de mudança de estado compartilhado e efeitos colaterais dificulta pensar localmente sobre o funcionamento do código. \pause

Por outros lado, podemos **pensar localmente** sobre o um código que não tem mudança de estados e nem efeitos colaterais.


Como?
=====

## Como?

1) Escolher uma linguagem. \pause

2) Estudar as construções do paradigma e as referências da linguagem. \pause

3) Praticar lendo e escrevendo código.


## Como?

1) Escolher uma linguagem \pause

   - Racket (variante moderna do Lisp) \pause

   - Bom suporte ao paradigma funcional

   - Ambiente integrado DrRacket

   - Documentação extensa

   - Fácil instalação


## Como?

2) Estudar as construções do paradigma e as referências da linguagem \pause

   - [A Tutorial Introduction to the Lambda Calculus](http://www.inf.fu-berlin.de/lehre/WS03/alpi/lambda.pdf)

   - Livro [How to Design Programs](http://htdp.org/)

   - [Guia](http://docs.racket-lang.org/guide/index.html)
  e [Referência](http://docs.racket-lang.org/reference/) do Racket

   - Livro [Structure and Interpretation of Computer Programs](https://web.mit.edu/6.001/6.037/sicp.pdf)

   - Livro [The Scheme Programming Languague](http://www.scheme.com/tspl4/ )


## Como?

3) Praticar lendo e escrevendo código \pause

   - Muitos exemplos \pause

   - Muitos exercícios



Primeiros passos
================

## Instalação

```console
$ apt-get install racket
```


## Execução

```console
$ drracket
```


## {.standout}

\begin{tikzpicture}[scale=0.85, transform shape]
    \node at (0, 0) {\includegraphics[width=\textwidth]{imagens/drracket-config.pdf}};
    \draw[line width=1pt, red] (-6.9cm, -4.4cm) rectangle ++(4.1cm, 0.4cm);
\end{tikzpicture}


## {.standout}

\begin{tikzpicture}[scale=0.85, transform shape]
    \node at (0, 0) {\includegraphics[width=\textwidth]{imagens/drracket-exemplo.pdf}};
    \node[red, yshift=1cm] {Definições};
    \node[red, yshift=-2cm] {Interações};
\end{tikzpicture}


## Uso

Na área de definições

- Digite o código do programa

- Pressione o botão executar/correr (ctrl + r))


## Uso

Na área de interações

- Teste as definições usando REPL (_Read Eval Print Loop_)

- Entre com uma expressão (_Read_)

- A expressão é avaliada (_Eval_)

- O resultado da expressão é impressa (_Print_)

- Repetida o processo (_Loop_)


## Uso

Exemplos de interações

```scheme
> 34
34
> (+ 3 4)
7
> (* 2 6)
12
> +
#<procedure:+>
```



Leitura
=======

## Leitura

Recomendada

- [Introdução rápida ao Racket](http://docs.racket-lang.org/quick/)

- [Programação funcional](https://en.wikipedia.org/wiki/Functional_programming)


Extra

- [The Python paradox](http://www.paulgraham.com/pypar.html)

- [Revenge of the Nerds](http://www.paulgraham.com/icad.html)

- [Beating the averages](http://www.paulgraham.com/avg.html)
