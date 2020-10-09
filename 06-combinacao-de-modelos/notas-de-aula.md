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

## Exemplo: prefixo

Dados duas listas `lsta` e `lstb`, defina uma função que verifique se `lsta`
é prefixo de `lstb`, isto é `lstb` começa com `lsta`.


## Exemplo: prefixo

- Passo 2: Assinatura, propósito e esboço

    ```scheme
    ;; Lista Lista -> Boolean
    ;; Devolve #t se lsta é prefixo de lstb,
    ;; #f caso contrário.
    (define (prefixo? lsta lstb) #f)
    ```


## Exemplo: prefixo

- Passo 3: Exemplos

    - Temos que ter pelo menos um exemplo para cada combinação das definições
      dos dados de entrada

    - `lsta` pode ser `empty` ou um `cons`

    - `lstb` pode ser `empty` ou um `cons`

    - Como garantir que não vamos esquecer nenhum caso? \pause Fazendo uma
      tabela!


## Exemplo: prefixo

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


## Exemplo: prefixo

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
(check-equal? (prefixo? empty empty) #t)
```


## Exemplo: prefixo

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
(check-equal? (prefixo? empty empty) #t)
(check-equal? (prefixo? empty (list 3 2 1)) #t)
```


## Exemplo: prefixo

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
(check-equal? (prefixo? empty empty) #t)
(check-equal? (prefixo? empty (list 3 2 1)) #t)
(check-equal? (prefixo? (list 3 2 1) empty) #f)
```


## Exemplo: prefixo

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


## Exemplo: prefixo

- Passo 4: modelo

    - Vamos criar um modelo com as quatro possibilidades

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


## Exemplo: prefixo

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
     |   empty    |            |                    |
lsta +------------+------------+--------------------+
     | (cons ...) |            |                    |
     |            |            |                    |
     +------------+------------+--------------------+
```


## Exemplo: prefixo

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
     |   empty    |     #t     |        #t          |
lsta +------------+------------+--------------------+
     | (cons ...) |     #f     |  primeiros iguais  |
     |            |            |     e recursão     |
     +------------+------------+--------------------+
```


## Exemplo: prefixo

\scriptsize

Simplificando ...

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
    [(empty? lstb) #f]    ;; escolhidos por ordem
    [else                 ;; de simplicidade
      (... (first lsta)
           (first lstb)
           (prefixo? (rest lsta) (rest lstb)))]))
```


## Exemplo: prefixo

- Passo 5: Corpo

    ```scheme
    (define (prefixo? lsta lstb)
      (cond
        [(empty? lsta) #t]
        [(empty? lstb) #f]
        [else
          (and (equal? (first lsta) (first lstb))
               (prefixo? (rest lsta) (rest lstb)))]))
    ```


## Exemplo: $k$-ésimo

Defina uma função que encontre o $k$-ésimo elemento de uma lista.


## Exemplo: $k$-ésimo

- Passo 2: Assinatura, propósito e esboço

    \scriptsize

    ```scheme
    ;; ListaDeNúmeros Natural -> Número
    ;; Devolve o elemento na posição k da lst.
    ;; O primeiro elemento está na posição 0.
    (define (lista-ref lst k) 0)
    ```


## Exemplo: $k$-ésimo

- Passo 3: Exemplos

    \scriptsize

    ```scheme
    ;; ListaDeNúmeros Natural -> Número
    ;; Devolve o elemento na posição k da lst.
    ;; O primeiro elemento está na posição 0.
    ;;                               k
    ;;                  +------------+-------------------+
    ;;                  |      0     | (add1 ...)        |
    ;;     +------------+------------+-------------------+
    ;;     |   empty    |    OK      |       OK          |
    ;; lst +------------+------------+-------------------+
    ;;     | (cons ...) |    OK      |       OK          |
    ;;     +------------+------------+-------------------+
    (check-exn exn:fail? (thunk (lista-ref empty 0)))
    (check-exn exn:fail? (thunk (lista-ref empty 2)))
    (check-equal? (lista-ref (list 3 2 8) 0) 3)
    (check-equal? (lista-ref (list 3 2 8 10) 2) 8)
    (check-exn exn:fail? (thunk (lista-ref (list 3 2 8 10) 4)))))
    (define (lista-ref k lst) 0)
    ```


## Exemplo: $k$-ésimo

- Passo 4: Modelo

    \scriptsize

    ```scheme
    ;; ListaDeNúmeros Natural -> Número
    ;; Devolve o elemento na posição k da lst.
    ;; O primeiro elemento está na posição 0.
    ;;                               k
    ;;                  +------------+-------------------+
    ;;                  |      0     | (add1 ...)        |
    ;;     +------------+------------+-------------------+
    ;;     |   empty    |          erro                  |
    ;; lst +------------+------------+-------------------+
    ;;     | (cons ...) | (first lst)|     recursão      |
    ;;     +------------+------------+-------------------+
    (check-exn exn:fail? (thunk (lista-ref empty 0)))
    (check-exn exn:fail? (thunk (lista-ref empty 2)))
    (check-equal? (lista-ref (list 3 2 8) 0) 3)
    (check-equal? (lista-ref (list 3 2 8 10) 2) 8)
    (check-exn exn:fail? (thunk (lista-ref (list 3 2 8 10) 4)))))
    (define (lista-ref k lst) 0)
    ```


## Exemplo: $k$-ésimo


- Passo 5: Corpo

    \scriptsize

    ```scheme
    ;; ListaDeNúmeros Natural -> Número
    ;;                               k
    ;;                  +------------+-------------------+
    ;;                  |      0     | (add1 ...)        |
    ;;     +------------+------------+-------------------+
    ;;     |   empty    |          erro                  |
    ;; lst +------------+------------+-------------------+
    ;;     | (cons ...) | (first lst)|     recursão      |
    ;;     +------------+------------+-------------------+
    (check-exn exn:fail? (thunk (lista-ref empty 0)))
    (check-exn exn:fail? (thunk (lista-ref empty 2)))
    (check-equal? (lista-ref (list 3 2 8) 0) 3)
    (check-equal? (lista-ref (list 3 2 8 10) 2) 8)
    (check-exn exn:fail? (thunk (lista-ref (list 3 2 8 10) 4)))))
    (define (lista-ref k lst)
      (cond
        [(empty? lst) (error "Lista vazia")]
        [(zero? k) (first lst)]
        [else (lista-ref (rest lst) (sub1 k))]))
    ```


Referências
===========

## Referências

- [Vídeos 2 one-of](https://www.youtube.com/playlist?list=PL6NenTZG6KrqrfIGWPW9CCVtXyugDk_eQ)
