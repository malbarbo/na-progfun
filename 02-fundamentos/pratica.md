---
# vim: set spell spelllang=pt_br sw=4:
title: Fundamentos - Prática
urlcolor: Black
# TODO: adicionar as soluções
# TODO: pensar nos objetivos dessa atividade e verificar se os exercícios são adequados
---

@) [sicp 1.1] Dado o seguinte programa, qual é o resultado impresso pelo Racket em resposta a cada expressão? Assuma que as expressões serão avaliadas na ordem em que são apresentadas.

    ```scheme
    10

    (+ 5 3 4)

    (- 9 1)

    (- 9)

    (/ 6 2)

    (/ 4)

    (*)

    (+)

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

@) Qual das seguintes construções formam expressões sintaticamente válidas em Racket? Justifique.

    a. `34 + 45`{.scheme}
    b. `(aplicar * 1 3 4 5)`{.scheme}
    c. `((if (> 0 8) - /) 10 20)`{.scheme}
    d. `(+ - * /)`{.scheme}
    e. `(if (> 4 9) 10)`{.scheme}

@) [sicp 1.2] Traduza a seguinte expressão para a forma prefixa $$\frac{5 + 4 + (2 - (3 - (6 + \frac{4}{5})))}{3 (6 - 2) (2 - 7)}$$

@) [tspl 2.2.2] Experimente os procedimentos `+`, `-`, `*` e `/` e determine as regras do Racket para o tipo do valor de retorno para cada procedimento quando são dados diferentes tipos de argumentos numéricos.

@) [sicp 1.4] O modelo de avaliação visto em sala permite combinações em que os operadores são expressões compostas. Use esta observação para descrever o comportamento do seguinte procedimento:

    ```scheme
    (define (a-plus-abs-b a b)
        ((if (> b 0) + -) a b))
    ```

@) [sicp 1.5] Ben Bitdiddle inventou um método para determinar se um interpretador está usando avaliação com ordem aplicativa ou avaliação com ordem normal. Ele definiu os seguintes procedimentos:

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

    Qual é o comportamento que Ben irá observar com um interpretador que usa avaliação com ordem aplicativa? Qual é o comportamento que ele irá observar com um interpretador que usa avaliação com ordem normal? Explique a sua resposta.
