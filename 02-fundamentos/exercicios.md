---
# vim: set spell spelllang=pt_br sw=4:
title: Fundamentos
---

#.  [sicp 1.1] A seguir está uma lista de expressões. Qual é o resultado
    impresso pelo interpretador Racket em resposta a cada expressão? Assuma que
    as expressões serão avaliadas na ordem em que são apresentadas.

    ```scheme
    10

    (+ 5 3 4)

    (- 9 1)

    (/ 6 2)

    (+ (* 2 4) (- 4 6))

    (define a 3)

    (define b (+ a 1))

    (+ a b (* a b))

    (= a b)

    (if (and (> b a) (< b (* a b)))
        b
        a)

    (cond [(= a 4) 6]
          [(= b 4) (+ 6 7 a)]
          [else 25])

    (+ 2 (if (> b a) b a))

    (* (cond [(> a b) a]
             [(< a b) b]
             [else -1])
       (+ a 1))
    ```

#.  [sicp 1.2] Traduza a seguinte expressão para a forma prefixa
    $$\frac{5 + 4 + (2 - (3 - (6 + \frac{4}{5})))}{3 (6 - 2) (2 - 7)}$$

#.  [tspl 2.2.2] Experimente os procedimentos `+`, `-`, `*` e `/` e determine
    as regras do Racket para o tipo do valor de retorno para cada procedimento
    quando são dados diferentes tipos de argumentos numéricos.

#.  [sicp 1.4] O modelo de avaliação visto em sala permite combinações em que
    os operadores são expressões compostas. Use esta observação para descrever
    o comportamento do seguinte procedimento:

    ```scheme
    (define (a-plus-abs-b a b)
        ((if (> b 0) + -) a b))
    ```

#.  [sicp 1.5] Ben Bitdiddle inventou um método para determinar se um
    interpretador está usando avaliação com ordem aplicativa ou avaliação com
    ordem normal. Ele definiu os seguintes procedimentos:

    ```scheme
    (define (p) (p))

    (define (test x y)
      (if (= x 0)
          0
          y))
    ```

    Então avaliou a seguinte expressão

    ```scheme
        (test 0 (p))
    ```

    Qual é o comportamento que Ben irá observar com um interpretador que usa
    avaliação com ordem aplicativa? Qual é o comportamento que ele irá observar
    com um interpretador que usa avaliação com ordem normal? Explique a sua
    resposta.

#.  Defina uma função que encontre o maior valor entre 2 valores dados.

#.  [sicp 1.3] Defina uma função que receba $3$ números como parâmetros
    e retorne a soma dos quadrados dos dois maiores números.

#.  Defina uma função que receba $3$ números que representam os lados de um
    triângulo como parâmetros e classifique o triângulo como equilátero (todos
    os lados iguais), isósceles (dois lados iguais) ou escaleno (todos os lados
    diferentes).

#.  O governo deu uma aumento de salário para os funcionários públicos.
    O percentual de aumento depende do valor do salário atual. Para
    funcionários que ganham até R$ 1200 o aumento é de 10%, para funcionários
    que ganham entre R$ 1200 e R$ 3000 o aumento é de 7%, para funcionários que
    ganham entre R$ 3000 e R$ 8000, o aumento é de 3%, e finalmente, para os
    funcionários que ganham mais que R$ 8000 não haverá aumento. Defina uma
    função que calcule o novo salário a partir do salário atual.

#.  Faça a execução passo a passo das funções definidas nos exercícios
    anteriores para alguns exemplos. Para isto você deve criar um novo arquivo,
    mudar a linguagem para "Beginning Student" e copiar o código da função e da
    chamada de exemplo.


# Referências

-   [sicp]. [Structure and Interpretation of Computer Programs](https://mitpress.mit.edu/sicp/)

-   [tspl]. [The Scheme Programming Languague](http://www.scheme.com/tspl4/)
