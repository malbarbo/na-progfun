---
# vim: set spell spelllang=pt_br sw=4:
title: Programação funcional
---

O quê?
======

## O quê?

Paradigma de programação inspirado no cálculo lambda. \pause

A computação é especificada pela definição e aplicação de funções (programação imperativa é baseado em mudança de estado). \pause

- Evita dados mutáveis e feitos colaterais



Por quê?
========

## Por quê?

Um paradigma (linguagem) de programação é uma ferramenta. \pause

Conhecer várias ferramentas permite utilizar a mais adequada para cada problema. \pause

Em geral os programas são \pause

- Mais simples, fáceis de entender e modificar. \pause

- Mais fáceis de paralelizar. \pause

Diversão! Programar (no paradigma funcional) é muito divertido.



Como?
=====

## Como?

Escolher uma linguagem. \pause

Ler a fundamentação teórica e as referências da linguagem. \pause

Praticar lendo e escrevendo código.


## Como?

Escolher uma linguagem \pause

- Racket \pause

- Bom suporte ao paradigma funcional

- Variante moderna do Lisp

- Ambiente integrado DrRacket

- Documentação extensa

- Fácil instalação


## Como?

Ler a fundamentação teórica e as referências da linguagem \pause

- [A Tutorial Introduction to the Lambda Calculus](http://www.inf.fu-berlin.de/lehre/WS03/alpi/lambda.pdf)

- Livro [How to Design Programs](http://htdp.org/)

- [Guia](http://docs.racket-lang.org/guide/index.html)
  e [Referência](http://docs.racket-lang.org/reference/) do Racket

- Livro [Structure and Interpretation of Computer Programs](https://mitpress.mit.edu/sicp/)

- Livro [The Scheme Programming Languague](http://www.scheme.com/tspl4/ )


## Como?

Praticar lendo e escrevendo código \pause

- Muitos exemplos

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

\vspace{1cm}
\begin{tikzpicture}[scale=0.94, transform shape]
    \node at (0, 0) {\includegraphics[width=\textwidth]{imagens/drracket-config.pdf}};
    \draw[line width=1pt, red] (-5.35cm, -3.42cm) rectangle ++(3.1cm, 0.36cm);
    \node[red, xshift=-2.9cm, yshift=-2.7cm] {Selecione esta opção};
\end{tikzpicture}


## {.standout}

\vspace{1cm}
\begin{tikzpicture}[scale=0.94, transform shape]
    \node at (0, 0) {\includegraphics[width=\textwidth]{imagens/drracket-exemplo.pdf}};
    \node[red, yshift=1cm] {Definições};
    \node[red, yshift=-2cm] {Interações};
\end{tikzpicture}


## Uso

Na área de definições

- Digite o código do programa

- Pressione o botão executar/correr (\keys{\ctrl + r})


## Uso

Na área de interações

- Teste as definições usando REPL (Read Eval Print Loop)

- Entre com uma expressão (Read)

- A expressão é avaliada (Eval)

- O resultado da expressão é impressa (Print)

- Repetida o processo (Loop)


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



Leitura recomendada
===================

## Leitura recomendada

[Introdução rápida ao Racket](http://docs.racket-lang.org/quick/)

[The Python paradox](http://www.paulgraham.com/pypar.html)

[Programação funcional](https://en.wikipedia.org/wiki/Functional_programming)

[Revenge of the Nerds](http://www.paulgraham.com/icad.html)

[Beating the averages](http://www.paulgraham.com/avg.html)
