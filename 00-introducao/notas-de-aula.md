---
title: Introdução
template: slide.tex
---

# O quê?

### O quê?

-   É um paradigma de programação baseado em funções modeladas sobre funções matemáticas

    -   Origem no cálculo lambda

-   A computação é especificada pela definição e aplicação de funções
    (Imperativo é baseado em mudança de estado)

    -   Evita dados mutáveis

# Por quê?

### Por quê?

-   Um paradigma (linguagem) de programação é uma ferramenta

-   Conhecer várias ferramentas para utilizar a mais adequada para cada problema

-   Programas mais simples, fáceis de entender e modificar

-   Programas mais fáceis de paralelizar (melhorar a utilização do hardware atual)

-   Diversão! Programar (no paradigma funcional) é muito divertido


# Como?

### Como?

-   Escolher uma linguagem

-   Ler a fundamentação teórica e as referências da linguagem

-   Praticar lendo e escrevendo código


### Como?

-   Escolher uma linguagem

    -   Racket

    -   Bom suporte ao paradigma funcional

    -   Variante moderna do Lisp

    -   Ambiente integrado DrRacket

    -   Documentação extensa

    -   Fácil instalação


### Como?

-   Ler a fundamentação teórica e as referências da linguagem

    -   Livro [How to Design Programs](http://htdp.org/)

    -   [Guia](http://docs.racket-lang.org/guide/index.html)
        e [Referência](http://docs.racket-lang.org/reference/) do Racket

    -   Livro [Structure and Interpretation of Computer Programs](https://mitpress.mit.edu/sicp/)

    -   Livro [The Scheme Programming Languague](http://www.scheme.com/tspl4/ )


### Como?

-   Praticar lendo e escrevendo código

    -   Muitos exemplos

    -   Muitos exercícios


## Primeiros passos

### Instalação e execução

- Instalação

    ```console
    $ apt-get install racket
    ```

- Execução

    ```console
    $ drracket
    ```

### Configuração

![](drracket-config)

### Uso

![](drracket-exemplo)

### Uso

-   Área de definições

    -   Digite o código do programa

    -   Pressione o botão correr (`ctrl+R`)

-   Área de interações

    -   Testar as definições

    -   REPL (Read Eval Print Loop)

        -   Entre com uma expressão (Read)

        -   A expressão é avaliada (Eval)

        -   O resultado da expressão é impressa (Print)

        -   O processo é repetido (Loop)

### Uso

- Exemplos de interações

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

# Leitura recomendada

### Leitura recomendada

- [The Python paradox](http://www.paulgraham.com/pypar.html)

- [Revenge of the Nerds](http://www.paulgraham.com/icad.html)

- [Beating the averages](http://www.paulgraham.com/avg.html)

- [Programação funcional](https://en.wikipedia.org/wiki/Functional_programming)

- [Introdução rápida ao Racket](http://docs.racket-lang.org/quick/)

<!-- vim: set spell spelllang=pt_br: !-->
