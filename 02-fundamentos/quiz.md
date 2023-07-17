# Questão 1

Sobre o paradigma de programação funcional, é correto afirmar que:

a) É baseado em mudança de estado

b) É o melhor paradigma de programação

c) É baseado na definição e aplicação de funções

d) É baseado na arquitetura de Von Neumann

e) Foi criado por programadores da antiguidade para alcançar paz de espírito enquanto programavam


# Questão 2

Na programação funcional, o que é uma expressão?

a) Qualquer parte de um programa

b) A cara que o programador faz quando programa

c) A única entidade necessário para programar

d) Uma unidade entidade sintática que produz um valor quando avaliada

e) Um conjunto de definições e expressões que mapeiam valores de entrada para valores de saída


# Questão 3

Na programação funcional, o que é uma função?

a) Um conjunto de definições e expressões que mapeiam valores de entrada para valores de saída

b) Uma expressão escrita com variáveis

c) Um trecho de programa qualquer

d) Uma unidade entidade sintática que produz um valor quando avaliada

e) Um objeto computacional armazenado na nuvem


# Questão 4

O que é uma combinação?

a) Um sequência de expressões

b) Um conjunto de expressões

c) Uma lista de expressões entre parênteses

d) Uma lista não vazia de expressões entre parênteses

e) Um par de expressões entre parênteses


# Questão 5

A expressão mais a esquerda em uma combinação é chamada de:

a) Expressão primária

b) Operando

c) Operador

d) Combinador

e) Cabeça


# Questão 6

Qual o resultado da avaliação da expressão `(* 3 (+ 1 2) (/ 10 2) 2)`{.scheme}?


# Questão 7

Como a expressão matemática $(3 + 1) \times 8 / (4 - 1)$ pode ser escrita em Racket?

a) `(/ (* (+ 3 1) 8) (- 4 1))`{.scheme}

b) `(+ 3 1 (* 8 (/ (- 4 1))))`{.scheme}

c) `(* (/ (+ 3 1) 8) (- 4 1))`{.scheme}

d) `(3 + 1) * 8 / (4 - 1)`{.scheme}

e) `(* (- 4 1) (/ (+ 3 1) 8))`{.scheme}


# Questão 8

Qual o resultado gerado para avaliação da seguinte expressão na janela de interações do Racket?

```scheme
(3 + 8)
```

a) Erro de sintaxe

b) `11`{.scheme}

c)

    ```scheme
    3
    #<procedure:+>
    8
    ```

d) Erro de execução: not a procedure

e) `#f`{.scheme}


# Questão 9

Dado a definição da função `f` a seguir, qual o resultado da avaliação de `(f (f 3))`{.scheme}? Use o modelo de substituição para calcular o valor.

```scheme
(define (f x)
  (* (+ x 1) (- x 1)))
```


# Questão 10

Qual o resultado da avaliação da expressão `((if (< 4 0) + -) 5 6)`{.scheme}? Use o modelo de substituição para calcular o valor.
