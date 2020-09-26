---
# vim: set spell spelllang=pt_br sw=4:
# TODO: deixar claro o que colocar na definição de tipo
# TODO: falar da simplificação de cond aninhados
# TODO: verificar pq os modelos usam cond ao invés de if
# TODO: falar sobre enumerações
# TODO: falar sobre uniões
# TODO: falar sobre tipos algébricos
title: Dados compostos
---

Introdução
==========

## Introdução

- Os tipos de dados que vimos até agora são atômicos, isto é, não podem ser
  decompostos

- Estamos interessados em representar dados onde dois ou mais valores devem
  ficar juntos

    - Registro de um aluno

    - Placar de um jogo de futebol

    - Informações de um produto

- Chamamos estes tipos de dados de **estruturas**


## Estruturas

- Em Racket utilizamos a forma especial `struct`{.scheme} para definir estruturas

\pause

- Vamos definir uma estrutura para representar um ponto em um plano cartesiano


## Estruturas

\small

```scheme
(struct ponto (x y))
(define p1 (ponto 3 4))
(define p2 (ponto 8 2))

> (ponto-x p1)
3
> (ponto-y p1)
4
> (ponto-x p2)
8
> (ponto-y p2)
2
> (ponto? p1)
#t
> (ponto? "ola")
#f
```


## Sintaxe de `struct`{.scheme}

- Uma aproximação da sintaxe do `struct`{.scheme} é

    ```scheme
    (struct <id-estrutura> (<id-campo-1> ...))
    ```


## Funções definidas na criação de uma estrutura

- Funções definidas pelo `struct`{.scheme}

    ```scheme
    ;; Construtor
    id-estrutura

    ;; Predicado que teste se o valor é do tipo definido
    id-estrutura?

    ;; Seletores
    id-estrutura-id-campo
    ```


## Funções definidas na criação de uma estrutura

- A estrutura

    ```scheme
    (struct ponto (x y))
    ```

- Define as funções

    ```scheme
    ;; Construtor
    ponto

    ;; Predicado
    ponto?

    ;; Seletores
    ponto-x
    ponto-y
    ```


## Estruturas transparentes

- Por padrão, ao exibir um dado estruturado o interpretador não exibe os
  campos do dado (para preservar o encapsulamento)

    ```scheme
    (struct ponto (x y))
    ```

    ```scheme
    > (ponto 3 4)
    #<ponto>
    ```


## Estruturas transparentes

- Podemos usar a palavra chave `#:transparent`{.scheme} para tornar a estrutura
  "transparente"

    ```scheme
    (struct ponto (x y) #:transparent)
    ```

    ```scheme
    ; mesmo formato de criação e de exibição
    > (ponto 3 4)
    (ponto 3 4)
    ```


## Estruturas transparentes e a função `equal?`

- Além de mudar a forma que o ponto é exibido, a palavra chave
  `#:transparent`{.scheme} também altera o funcionamento da função `equal?`


## Estruturas transparentes e a função `equal?`

```scheme
;; Por padrão, dois pontos são iguais se eles são
;; o mesmo ponto
(struct ponto (x y))
(define p1 (ponto 3 4))
(define p2 (ponto 3 4))

> (equal? p1 p2)
#f
> (equal? p1 p1)
#t
```


## Estruturas transparentes e a função `equal?`

```scheme
;; Com :#transparent, dois pontos são iguais se os seus
;; campos são iguais
(struct ponto (x y) #:transparent)
(define p1 (ponto 3 4))
(define p2 (ponto 3 4))

> (equal? p1 p2)
#t
> (equal? p1 p1)
#t
```


## Definindo estruturas

- Junto com a definição de uma estrutura, também faremos

    - A descrição do propósito e campos da estrutura

    - Exemplos

    - Modelo


## Definindo estruturas

```scheme
(struct ponto (x y))
;; Ponto representa um ponto no plano cartesiano
;;   x : Número - a coordenada x
;;   y : Número - a coordenada y
;; Exemplos
#;
(define p1 (ponto 3 4))
#;
(define p2 (ponto 8 2))
```


## Definindo estruturas

```scheme
;; Modelo
#;
(define (fun-for-ponto p)
  (... (ponto-x p)
       (ponto-y p)))
```

```scheme
;; A sequência #; comenta a próxima s-exp. Nos exemplos
;; do primeiro ( até o ) correspondente.
```


## Alterando dados estruturados

- Se quisermos mudar um campo de um dado estruturado, temos que criar uma cópia
  com o campo alterado

- Vamos criar um ponto `p2` que é como `p1`, mas com o valor 5 para
  o campo `y`

    ```scheme
    > (define p1 (ponto 3 4))
    > (define p2 (ponto (ponto-x p1) 5))
    > p2
    (ponto 3 5)
    ```


## Alterando dados estruturados

- Este método é limitado

    - Se a estrutura tem muitos campos e desejamos alterar apenas um campo,
      temos que especificar a cópia de todos os outros

    - Se a estrutura é alterada, todas as operações de "cópia" devem ser
      alteradas


## Alterando dados estruturados

- Racket oferece a forma especial `struct-copy`
  ([referência](http://docs.racket-lang.org/reference/struct-copy.html)), que
  facilita este tipo de operação


## Alterando dados estruturados

```scheme
> (define p2 (struct-copy ponto p1
                                [y 5]))
> p2
(ponto 3 5)
> (define p3 (struct-copy ponto p2
                                [x 4]))
> p3
(ponto 4 5)
> (define p4 (struct-copy ponto p2
                                [y 9]
                                [x 6]))
> p4
(ponto 6 9)
```


## Exemplo 3.1

Defina uma função que calcule a distância de um ponto a origem.


## Exemplo 3.2

Defina uma estrutura para representar um retângulo. Em seguida defina uma
função que classifique um retângulo em largo (largura maior que altura), alto
(altura maior que largura) ou quadrado (altura igual a largura).


## Enumerações

- Vimos durante a aula


## Uniões

- Vimos durante a aula


## Tipos algébricos

- Vimos durante a aula



Referências
===========

## Referências

- [Vídeos Compound Data](https://www.youtube.com/playlist?list=PL6NenTZG6KrpA-ww35EwcaxY-tgh82TAh)

- [Vídeos Reference](https://www.youtube.com/watch?v=tp44seRHLUQ&list=PL6NenTZG6KrptkOEMyLWDnF0ZjSpVTHAE)


- Seções
    [5.1](http://docs.racket-lang.org/guide/define-struct.html) do
    [Guia Racket](http://docs.racket-lang.org/guide/)


## Referências complementares

- Seções
    [4.1](http://docs.racket-lang.org/reference/structures.html) da
    [Referência Racket](http://docs.racket-lang.org/reference/)
