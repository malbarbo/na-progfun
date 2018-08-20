---
title: Fundamentos
num: "2"
template: exercicios.tex
---

#.  [sicp 1.1] A seguir está uma lista de expressões. Qual é o resultado
    impresso pelo interpretador Racket em resposta a cada expressão? Assuma que
    as expressões serão avaliadas na ordem em que são apresentadas.

    ```racket
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

#.  [sicp 1.2] Traduza a seguinte expressão para a forma pré-fixa
    $$\frac{5 + 4 + (2 - (3 - (6 + \frac{4}{5})))}{3 (6 - 2) (2 - 7)}$$

#.  [tspl 2.2.2] Experimente os procedimentos `+`, `-`, `*` e `/` e determine
    as regras do Racket para o tipo do valor de retorno para cada procedimento
    quando são dados diferentes tipos de argumentos numéricos.

#.  [sicp 1.4] O modelo de avaliação visto em sala permite combinações em que
    os operadores são expressões compostas. Use esta observação para descrever
    o comportamento do seguinte procedimento:

    ```racket
    (define (a-plus-abs-b a b)
        ((if (> b 0) + -) a b))
    ```

#.  [sicp 1.5] Ben Bitdiddle inventou um método para determinar se um
    interpretador está usando avaliação com ordem aplicativa ou avaliação com
    ordem normal. Ele definiu os seguintes procedimentos:

    ```racket
    (define (p) (p))

    (define (test x y)
      (if (= x 0)
          0
          y))
    ```

    Então avaliou a seguinte expressão

    ```racket
        (test 0 (p))
    ```

    Qual é o comportamento que Ben irá observar com um interpretador que usa
    avaliação com ordem aplicativa? Qual é o comportamento que ele irá observar
    com um interpretador que usa avaliação com ordem normal? Explique a sua
    resposta.

#.  Defina uma função que encontre o maior valor entre 2 valores dados.

#.  [sicp 1.3] Defina uma função que receba $3$ números como parâmetros
    e retorne a soma dos quadrados dos dois maiores números.

#.  Defina uma função que calcule a distância de um ponto no plano cartesiano
    (representado por dois números) à origem.

#.  Defina uma função que receba como parâmetros $3$ números que representam os
    lados de um triângulo e classifique o triângulo como equilátero, isósceles
    ou escaleno. Veja a página sobre
    [triângulos](https://pt.wikipedia.org/wiki/Tri%C3%A2ngulo) na Wikipédia.

#.  Defina uma função que classifique o grau de obesidade de uma pessoa usando
    o [IMC](https://pt.wikipedia.org/wiki/%C3%8Dndice_de_massa_corporal).

#.  Faça a execução passo a passo das funções definidas nos exercícios
    anteriores para alguns exemplos. Para isto você deve criar um novo arquivo,
    mudar a linguagem para "Beginning Student" e copiar o código da função e da
    chamada de exemplo.


# Referências

-   [sicp]. [Structure and Interpretation of Computer Programs](https://mitpress.mit.edu/sicp/)

-   [tspl]. [The Scheme Programming Languague](http://www.scheme.com/tspl4/)

<!-- vim: set spell spelllang=pt_br: !-->
