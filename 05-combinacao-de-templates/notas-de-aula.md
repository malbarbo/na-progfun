---
title: Combinação de templates
template: slide.tex
---

# Introdução

### Introdução

-   Qual template utilizar quando a função consome dois ou mais tipos de dados?
    \pause

    -   Se apenas um dado é definido por mais que uma cláusula (como por
        exemplo, uma lista), utilizamos o template correspondente

    -   Se mais que dois dados de entrada são definidos por mais que uma
        cláusula, devemos fazer uma combinação dos templates

# Exemplos

### Exemplo 5.1

Dados duas listas `lsta` e `lstb`, defina uma função que verifique se `lsta`
é prefixo de `lstb`, isto é `lstb` começa com `lsta`.

### Exemplo 5.1

-   Passo 1: Assinatura, propósito e cabeçalho

    ```racket
    ;; Lista Lista -> Boolean
    ;; Devolve true se lsta é prefixo de lstb. false caso contrário.
    (define (prefixo? lsta lstb) false)
    ```

### Exemplo 5.1

-   Passo 2: Exemplos

    -   Temos ter pelo menos um exemplo para cada combinação das definições dos
        dados de entrada

    -   `lsta` pode ser `empty` ou um `cons`

    -   `lstb` pode ser `empty` ou um `cons`

    -   Como garantir que não vamos esquecer nenhum caso? \pause Fazendo uma
        tabela

### Exemplo 5.1

```text
                             lstb
                  +------------+------------+
                  |   empty    | (cons ...) |
     +------------+------------+------------+
     |   empty    |            |            |
lsta +------------+------------+------------+
     | (cons ...) |            |            |
     +------------+------------+------------+
```

### Exemplo 5.1

```text
                             lstb
                  +------------+------------+
                  |   empty    | (cons ...) |
     +------------+------------+------------+
     |   empty    |     OK     |            |
lsta +------------+------------+------------+
     | (cons ...) |            |            |
     +------------+------------+------------+
```

```racket
(check-equal? (prefixo? empty empty) true)
```

### Exemplo 5.1

```text
                             lstb
                  +------------+------------+
                  |   empty    | (cons ...) |
     +------------+------------+------------+
     |   empty    |     OK     |     OK     |
lsta +------------+------------+------------+
     | (cons ...) |            |            |
     +------------+------------+------------+
```

```racket
(check-equal? (prefixo? empty empty) true)
(check-equal? (prefixo? empty (list 3 2 1)) true)
```

### Exemplo 5.1

```text
                             lstb
                  +------------+------------+
                  |   empty    | (cons ...) |
     +------------+------------+------------+
     |   empty    |     OK     |     OK     |
lsta +------------+------------+------------+
     | (cons ...) |     OK     |            |
     +------------+------------+------------+
```

```racket
(check-equal? (prefixo? empty empty) true)
(check-equal? (prefixo? empty (list 3 2 1)) true)
(check-equal? (prefixo? (list 3 2 1) empty) false)
```

### Exemplo 5.1

```text
                             lstb
                  +------------+------------+
                  |   empty    | (cons ...) |
     +------------+------------+------------+
     |   empty    |     OK     |     OK     |
lsta +------------+------------+------------+
     | (cons ...) |     OK     |     OK     |
     +------------+------------+------------+
```

```racket
(check-equal? (prefixo? empty empty) true)
(check-equal? (prefixo? empty (list 3 2 1)) true)
(check-equal? (prefixo? (list 3 2 1) empty) false)
(check-equal? (prefixo? (list 3 4) (list 3 4)) true)
(check-equal? (prefixo? (list 3 4) (list 3 5)) false)
(check-equal? (prefixo? (list 3 4) (list 3 4 6 8)) true)
(check-equal? (prefixo? (list 3 5) (list 3 4 6 8)) false)
(check-equal? (prefixo? (list 3 4 5) (list 3 4)) false)
```

### Exemplo 5.1

-   Passo 3: template

    -   Baseado na tabela, vamos criar um template

    \pause

    ```racket
    (define (prefixo? lsta lstb)
      (cond
        [(and (empty? lsta) (empty? lstb)) ...]
        [(and (empty? lsta) (cons? lstb)) ... lstb ...]
        [(and (cons? lsta) (empty? lstb)) ... lsba ...]
        [else ... lsta ... lstb ...]))
    ```

    \pause

    -   Este template é muito complicado... \pause

    -   Baseado nos exemplos, vamos preencher a tabela e derivar um template
        mais simples

### Exemplo 5.1

```racket
(check-equal? (prefixo? empty empty) true)
(check-equal? (prefixo? empty (list 3 2 1)) true)
(check-equal? (prefixo? (list 3 2 1) empty) false)
(check-equal? (prefixo? (list 3 4) (list 3 4)) true)
(check-equal? (prefixo? (list 3 4) (list 3 5)) false)
(check-equal? (prefixo? (list 3 4) (list 3 4 6 8)) true)
(check-equal? (prefixo? (list 3 5) (list 3 4 6 8)) false)
(check-equal? (prefixo? (list 3 4 5) (list 3 4)) false)
```

```text
                             lstb
                  +------------+--------------------+
                  |    empty   |     (cons ...)     |
     +------------+------------+--------------------+
     |   empty    |    true    |        true        |
lsta +------------+------------+--------------------+
     | (cons ...) |    false   |  primeiros iguais  |
     |            |            | e recursão natural |
     +------------+------------+--------------------+
```

### Exemplo 5.1

-   Simplificando ...

```text
                             lstb
                  +------------+--------------------+
                  |    empty   |     (cons ...)     |
     +------------+------------+--------------------+
     |   empty    |              true               |
lsta +------------+------------+--------------------+
     | (cons ...) |    false   |  primeiros iguais  |
     |            |            | e recursão natural |
     +------------+------------+--------------------+
```

-   Template (observe que alguma parte do corpo já foi escrita)

    ```racket
    (define (prefixo? lsta lstb)
      (cond
        [(empty? lsta) true]    ;; os casos foram
        [(empty? lstb) false]   ;; escolhidos por ordem
        [else ...               ;; de simplicidade
              (first lsta)
              (first lstb)
              (prefixo? (rest lsta) (rest lstb))]))
    ```

### Exemplo 5.1

-   Passo 4: Corpo

    ```racket
    (define (prefixo? lsta lstb)
      (cond
        [(empty? lsta) true]
        [(empty? lstb) false]
        [else (and
                (equal? (first lsta) (first lstb))
                (prefixo? (rest lsta) (rest lstb)))]))
    ```

### Exemplo 5.2

Defina uma função que encontre o $k$-ésimo elemento de uma lista.


# Referências

### Referências

-   [Vídeos 2 one-of](https://www.youtube.com/playlist?list=PL6NenTZG6KrqrfIGWPW9CCVtXyugDk_eQ)

<!-- vim: set spell spelllang=pt_br: !-->
