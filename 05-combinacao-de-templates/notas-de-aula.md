---
# vim: set spell spelllang=pt_br sw=4:
title: Combinação de modelos
---

Introdução
==========

## Introdução

- Qual modelo utilizar quando a função consome dois ou mais tipos de dados?
  \pause

    - Se apenas um dado é definido por mais que uma cláusula (como por exemplo,
      uma lista), utilizamos o modelo correspondente

    - Se mais que dois dados de entrada são definidos por mais que uma
      cláusula, devemos fazer uma combinação dos modelos


Exemplos
========

## Exemplo 5.1

Dados duas listas `lsta` e `lstb`, defina uma função que verifique se `lsta`
é prefixo de `lstb`, isto é `lstb` começa com `lsta`.


## Exemplo 5.1

- Passo 1: Assinatura, propósito e cabeçalho

    ```scheme
    ;; Lista Lista -> Boolean
    ;; Devolve #t se lsta é prefixo de lstb,
    ;; #f caso contrário.
    (define (prefixo? lsta lstb) #f)
    ```


## Exemplo 5.1

- Passo 2: Exemplos

    - Temos que ter pelo menos um exemplo para cada combinação das definições
      dos dados de entrada

    - `lsta` pode ser `empty` ou um `cons`

    - `lstb` pode ser `empty` ou um `cons`

    - Como garantir que não vamos esquecer nenhum caso? \pause Fazendo uma
      tabela


## Exemplo 5.1

\small

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


## Exemplo 5.1

\small

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

```scheme
(check-equal? (prefixo? empty empty) true)
```


## Exemplo 5.1

\small

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

```scheme
(check-equal? (prefixo? empty empty) true)
(check-equal? (prefixo? empty (list 3 2 1)) true)
```


## Exemplo 5.1

\small

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

```scheme
(check-equal? (prefixo? empty empty) true)
(check-equal? (prefixo? empty (list 3 2 1)) true)
(check-equal? (prefixo? (list 3 2 1) empty) false)
```


## Exemplo 5.1

\small

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

```scheme
(check-equal? (prefixo? empty empty) #t)
(check-equal? (prefixo? empty (list 3 2 1)) #t)
(check-equal? (prefixo? (list 3 2 1) empty) #f)
(check-equal? (prefixo? (list 3 4) (list 3 4)) #t)
(check-equal? (prefixo? (list 3 4) (list 3 5)) #f)
(check-equal? (prefixo? (list 3 4) (list 3 4 6 8)) #t)
(check-equal? (prefixo? (list 3 5) (list 3 4 6 8)) #f)
(check-equal? (prefixo? (list 3 4 5) (list 3 4)) #f)
```


## Exemplo 5.1

- Passo 3: modelo

    - Baseado na tabela, vamos criar um modelo

    \pause

    ```scheme
    (define (prefixo? lsta lstb)
      (cond
        [(and (empty? lsta) (empty? lstb)) ...]
        [(and (empty? lsta) (cons? lstb)) ... lstb ...]
        [(and (cons? lsta) (empty? lstb)) ... lsba ...]
        [else ... lsta ... lstb ...]))
    ```

    \pause

    - Este modelo é muito complicado... \pause

    - Baseado nos exemplos, vamos preencher a tabela e derivar um modelo mais
      simples


## Exemplo 5.1

\scriptsize

```scheme
(check-equal? (prefixo? empty empty) #t)
(check-equal? (prefixo? empty (list 3 2 1)) #t)
(check-equal? (prefixo? (list 3 2 1) empty) #f)
(check-equal? (prefixo? (list 3 4) (list 3 4)) #t)
(check-equal? (prefixo? (list 3 4) (list 3 5)) #f)
(check-equal? (prefixo? (list 3 4) (list 3 4 6 8)) #t)
(check-equal? (prefixo? (list 3 5) (list 3 4 6 8)) #f)
(check-equal? (prefixo? (list 3 4 5) (list 3 4)) #f)
```

```text
                             lstb
                  +------------+--------------------+
                  |    empty   |     (cons ...)     |
     +------------+------------+--------------------+
     |   empty    |     #t     |         #t         |
lsta +------------+------------+--------------------+
     | (cons ...) |     #f     |  primeiros iguais  |
     |            |            | e recursão natural |
     +------------+------------+--------------------+
```


## Exemplo 5.1 (simplificando...)

\scriptsize

```text
                             lstb
                  +------------+--------------------+
                  |    empty   |     (cons ...)     |
     +------------+------------+--------------------+
     |   empty    |              #t                 |
lsta +------------+------------+--------------------+
     | (cons ...) |     #f     |  primeiros iguais  |
     |            |            | e recursão natural |
     +------------+------------+--------------------+
```


```scheme
;; Modelo (observe que alguma parte do corpo já foi escrita)
(define (prefixo? lsta lstb)
  (cond
    [(empty? lsta) #t]    ;; os casos foram
    [(empty? lstb) #f]   ;; escolhidos por ordem
    [else ...               ;; de simplicidade
          (first lsta)
          (first lstb)
          (prefixo? (rest lsta) (rest lstb))]))
```


## Exemplo 5.1

- Passo 4: Corpo

    ```scheme
    (define (prefixo? lsta lstb)
      (cond
        [(empty? lsta) #t]
        [(empty? lstb) #f]
        [else (and
                (equal? (first lsta) (first lstb))
                (prefixo? (rest lsta) (rest lstb)))]))
    ```


## Exemplo 5.2

Defina uma função que encontre o $k$-ésimo elemento de uma lista.



Referências
===========

## Referências

- [Vídeos 2 one-of](https://www.youtube.com/playlist?list=PL6NenTZG6KrqrfIGWPW9CCVtXyugDk_eQ)
