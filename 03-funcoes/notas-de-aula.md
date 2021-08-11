---
# vim: set spell spelllang=pt_br sw=4:
title: Funções
---

## Como projetar funções

<!-- TODO: explicar como instalar a biblioteca examples !-->
<!-- Colocar mais exemplos (trocar é par) !-->

- Vamos utilizar as receitas de projeto do livro [How to Design
  Programs](http://htdp.org) para escrever funções

- Essas receitas permitem o projeto sistemático de funções

- Esse processo pode não ser relevante para problemas simples, mas é essencial
  para os demais problemas

- Seja paciente e em breve você verá a utilidade desse processo

- Vamos treinar com problemas simples, para depois utilizar o processo em
  outros problemas


## Como projetar funções

1. Análise do problema e definição de dados

2. Assinatura, propósito e esboço

3. Exemplos

4. Modelo

5. Corpo

6. Teste e depuração


## Como projetar funções

- Cada etapa depende da anterior, mas às vezes pode ser necessário mudar a
  ordem

- Por exemplo, talvez você faça primeiro os exemplos para entender melhor o
  problema e poder escrever a assinatura e o propósito

- Às vezes você está escrevendo o corpo e encontra uma nova condição e deve
  voltar e alterar o propósito e os exemplos

- Mas você nunca deve escrever o corpo diretamente


## Como projetar funções

- Um modelo contém a estrutura básica que uma função deve ter, independente dos
  seu detalhes

- Em muitos casos o modelo de uma função é determinado pelos tipos de dados dos
  seus parâmetros. Este tipo de modelo é chamado de modelo dirigido por dados

- Para tipos atômicos (números, strings, booleanos) usamos o modelo:

    ```scheme
    (define (fn-para-atomico a)
        (... a))
    ```

- Para outros tipos, vamos construir o modelo com a definição do tipo


## Dobro

Defina uma função que calcule o dobro de um dado valor.


## Dobro

- Passo 2: Assinatura, propósito e esboço

    ```scheme
    ;; Número -> Número
    ;; Produz o dobro de n.
    (define (dobro n) 0)
    ```

- Convenções:

    - Nome do tipo usando CamelCase

    - Nome da função em minúsculo usando `-` para separar as palavras


## Dobro

- Passo 3: Exemplos

    ```scheme
    ;; Número -> Número
    ;; Produz o dobro de n.
    (check-equal? (dobro 0) 0)
    (check-equal? (dobro 4) 8)
    (check-equal? (dobro -2) -4)

    (define (dobro n) 0)
    ```


## Dobro

- Passo 4: Modelo

- Como o parâmetro é um número, usamos o modelo para tipos atômicos

    ```scheme
    ;; Número -> Número
    ;; Produz o dobro de n.
    (check-equal? (dobro 0) 0)
    (check-equal? (dobro 4) 8)
    (check-equal? (dobro -2) -4)
    ; (define (dobro n) 0) ; esboço

    (define (fn-para-atomico a)
        (... a))
    ```


## Dobro

- Passo 4: Modelo

- Ajustamos os nomes no modelo para a função que estamos definindo

    ```scheme
    ;; Número -> Número
    ;; Produz o dobro de n.
    (check-equal? (dobro 0) 0)
    (check-equal? (dobro 4) 8)
    (check-equal? (dobro -2) -4)
    ; (define (dobro n) 0) ; esboço

    (define (dobro n)
        (... n))
    ```


## Dobro

- Passo 6: Corpo

- Baseado nos passos anteriores, escrevemos o corpo da função

    ```scheme
    ;; Número -> Número
    ;; Produz o dobro de n.
    (check-equal? (dobro 0) 0)
    (check-equal? (dobro 4) 8)
    (check-equal? (dobro -2) -4)
    ; (define (dobro n) 0) ; esboço

    (define (dobro n)
        (* 2 n))
    ```


## Dobro

Programa completo

\small

```scheme
#lang racket

(require examples)

;; Número -> Número
;; Produz o dobro de n.
(examples
 (check-equal? (dobro 0) 0)
 (check-equal? (dobro 4) 8)
 (check-equal? (dobro -2) -4))

(define (dobro n)
  (* 2 n))
```


## Dobro

- Passo 6: Teste e depuração

  - ctrl + r ou F5 para executar o programa (e os testes)

- Resultado

    ```text
    3 success(es) 0 failure(s) 0 error(s) 3 test(s) run
    ```


## Par

Defina uma função que verifique se um número é par.


## Maior palavra

Defina uma função que encontre a maior palavra entre duas palavras dadas.


Referências
===========

## Referências básicas

- [Vídeos BSL](https://www.youtube.com/playlist?list=PL6NenTZG6Krqu5RRQi3TUGc605rrGGGWw)

- [Vídeos How to Design Functions](https://www.youtube.com/playlist?list=PL6NenTZG6KroMpbQDFNmv6YuydU1DTklw)
