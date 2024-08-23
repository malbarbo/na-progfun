---
# vim: set spell spelllang=pt_br sw=4:
# TODO: adicionar exemplos para a chamada da função com acumuladores
# TODO: usar um exemplo "mais simples" para introduzir o conceito (o exemplo da soma?)
# TODO: apresentar uma forma diferente de projeto (como em fundamentos de algoritmos)? Seria necessário deixar de lado a ideia de que acumulador é algo se faz depois?
# TODO: ao invés de apresentar foldl e foldr separados, unir os dois assuntos em "percurso de listas"?
# TODO: adicionar exemplo com mais de um acumulador
# TODO: adicionar um exemplo que a resposta não é o acumulador
title: Acumuladores
---

Introdução
==========

## Falta de contexto na recursão

Até agora não nos preocupamos com o contexto do uso quando criamos funções recursivas, \pause não importa se é a primeira vez que a função está sendo chamada ou se é a 100ª. \pause

Este princípio de independência do contexto facilita a escrita de funções recursivas, mas pode gerar problemas em algumas situações. \pause

Vamos ver um exemplo.


## Exemplo

Dado uma lista de distâncias relativas entre pontos (começando da origem) em uma linha, defina uma função que calcule a distância absoluta a partir da origem.


## Exemplo

\scriptsize

```scheme
;; Lista(Número) -> Lista(Número)
;; Converte uma lista de distâncias relativas para uma lista
;; de distâncias absolutas. O primeito item da lista
;; representa a distância da origem.
(examples
 (check-equal? (relativa->absoluta empty) empty)
 (check-equal? (relativa->absoluta
                (list 50 40  70  30  30))
                (list 50 90 160 190 220)))
```

\pause

```scheme
(define (relativa->absoluta lst)
  (cond
    [(empty? lst) ...]
    [else
     (... (first lst)
          (relativa->absoluta (rest lst)))]))
```


## Exemplo

\small

Para a entrada `(list 50 40 70 30 30)`{.scheme} a função deve produzir como saída `(list 50 90 160 190 220)`{.scheme}. \pause

Como combinar `(first lst)`{.scheme} -- `50`{.scheme} -- com `(relativa->absoluta (rest lst))`{.scheme} -- `(list 40 110 140 170)`{.scheme} -- para obter a resposta para `lst`{.scheme}? \pause

```scheme
(list 50 40 70 30 30)   ->   (list 50 90 160 190 220)

                            50  (list 40 110 140 170)
                             |  |
                   (first lst)  (relativa->absoluta (rest lst))
```

\pause

Somando `50`{.scheme} a cada elemento de `(list 40 110 140 170)`{.scheme} \pause

```scheme
(cons 50 (map (curry + 50) (list 40 110 140 170)))
```


## Exemplo

<div class="columns">
<div class="column" width="54%">

\footnotesize

```scheme
;; Lista(Número) -> Lista(Número)
;; Converte uma lista de distâncias relativas
;; para uma lista de distâncias absolutas. O
;; primeito item da lista representa a
;; distância da origem.
(examples
 (check-equal? (relativa->absoluta
                (list 50 40  70  30  30))
                (list 50 90 160 190 220)))
(define (relativa->absoluta lst)
  (cond
    [(empty? lst) empty]
    [else
     (cons
       (first lst)
       (map (curry + (first lst))
            (relativa->absoluta (rest lst))))]))
```

</div>
<div class="column" width="44%">

Qual é o problema dessa função? \pause

Ela realiza muito trabalho! O tempo de execução é $\Theta(n^2)$. \pause

Podemos melhorar? \pause Sim! \pause

Como resolveríamos o problema manualmente? \pause

Somando a distância absoluta de um ponto com a distância relativa do próximo. \pause

Vamos tentar definir uma função mais parecida com este método manual.

</div>
</div>


## Exemplo

Começamos com o modelo

```scheme
(define (relativa->absoluta lst)
  (cond
    [(empty? lst) ...]
    [else (... (first lst)
               (relativa->absoluta (rest lst)))]))
```


## Exemplo

<div class="columns">
<div class="column" width="48%">
\footnotesize

Como seria a avaliação de `(relativa->absoluta (list 3 2 7))`{.scheme}? \pause

```scheme
(relativa->absoluta (list 3 2 7))
```

\pause

```scheme
(cons ... 3 ...
  (relativa->absoluta (list 2 7)))
```

\pause

```scheme
(cons ... 3 ...
  (cons ... 2 ...
    (relativa->absoluta (list 7))))
```

\pause

```scheme
(cons ... 3 ...
  (cons ... 2 ...
    (cons ... 7 ...
      emtpy)))
```

\pause
</div>
<div class="column" width="48%">

\small

Qual é e como obter o primeiro item da resposta? \pause `3`{.scheme} e calculamos diretamente. \pause

Qual é e como obter o segundo item da resposta. \pause `5`{.scheme} e obtemos com `(+ 3 2)`{.scheme}. \pause Na segunda chamada de `relativa->absoluta` obtemos o `2`{.scheme} com `(first lst)`{.scheme}, mas como obtemos o `3`{.scheme}? \pause Não temos como obter o `3`{.scheme} pois a recursão é **independe** do que "aconteceu" antes, ou seja, é independente do contexto! \pause O mesmo acontece para o terceiro item, temos que obter `(+ 5 7)`{.scheme} mas não temos acesso ao `5`{.scheme}. \pause

Como resolver esse problema, isto é, como acessar a distância absoluta anterior para calcular a distância atual? \pause Adicionando um novo parâmetro que representa a distância absoluta anterior, ou seja, um contexto para a chamada da função.

</div>
</div>


## Exemplo

Com um novo parâmetro, o início da implementação fica

\footnotesize

```scheme
;; acc-dist é a distância absoluta do item
;; anterior que estava antes do primeiro elemento de lst.
(define (relativa->absoluta lst acc-dist)
  (cond
    [(empty? lst) ...]
    [else
     (... acc-dist
          (first lst)
          (relativa->absoluta (rest lst) ...))]))
```

\pause

\normalsize

O parâmetro `acc-dist` é um **acumulador**, isto é, uma variável que representa o contexto que a função está sendo chamada. \pause Em geral, um acumulador é um resultado parcial do processamento das chamadas recursivas anteriores.


## Exemplo

\small

Para a entrada `(list 3 2 7)`{.scheme}, qual deve ser a chamada inicial? \pause `(relativa->absoluta (list 3 2 7) ...)`{.scheme} \pause

Durante a chamada `(relativa->absoluta (list 3 2 7) ...)`{.scheme}, como é a chamada recursiva para `(rest (list 3 2 7))`{.scheme}? \pause

`(relativa->absoluta (rest (list 3 2 7)) 3)`{.scheme}. \pause

Durante a chamada `(relativa->absoluta (list 2 7) 3)`{.scheme}, como é chamada a recursiva para `(rest (list 2 7))`{.scheme}? \pause

`(relativa->absoluta (rest (list 2 7)) 5)`{.scheme}. \pause Como obtemos `5`{.scheme}? \pause `(+ 2 3)`{.scheme} \pause

De forma geral, como é a chamada recursiva? \pause

`(relativa->absoluta (rest lst) (+ (first lst) acc-dist))`{.scheme} \pause

Para a entrada `(list 3 2 7)`{.scheme}, qual deve ser a chamada inicial? \pause `(relativa->absoluta (list 3 2 7) 0)`{.scheme}


## Exemplo

Completando a função obtemos

\small

```scheme
(define (relativa->absoluta lst acc-dist)
  (cond
    [(empty? lst) empty]
    [else
     (cons (+ (first lst) acc-dist)
           (relativa->absoluta (rest lst)
                               (+ (first lst) acc-dist)))]))
```

\pause

\normalsize

Note que o parâmetro `acc-dist`{.scheme} não é relevante para o problema, apenas para a solução. Então podemos encapsular a solução sem expor o existência do argumento `acc-dist`{.scheme}.


## Exemplo

\small

```scheme
(define (relativa->absoluta lst0)
  (define (iter lst acc-dist)
    (cond
      [(empty? lst) empty]
      [else
       (cons (+ (first lst) acc-dist)
             (iter (rest lst)
                   (+ (first lst) acc-dist)))]))
  (iter lst0 0))
```

\normalsize

Por convenção, chamamos a função com o acumulador de `iter`, em breve veremos porque.


## Falta de contexto na recursão

No exemplo `relativa->absoluta`{.scheme} vimos que a falta de contexto durante a recursão tornou a função mais complicada e mais lenta do que o necessário. \pause

Agora veremos um exemplo em que a falta de contexto faz uma função usar mais memória do que o necessário.


Processos iterativos e recursivos
=================================


## Processos iterativos e recursivos

Considere as seguintes implementações para a função que soma dois números naturais utilizando a função `add1`{.scheme}, `sub1`{.scheme} e `zero?`{.scheme}

\small

```scheme
(define (soma a b)
  (if (zero? b)
      a
      (add1 (soma a (sub1 b)))))

(define (soma-alt a b)
  (if (zero? b)
      a
      (soma-alt (add1 a) (sub1 b))))
```

\normalsize

Qual é o processo gerado quando cada função é avaliada com os parâmetros `4`{.scheme} e `3`{.scheme}?


## Processos iterativos e recursivos

<div class="columns">
<div class="column" width="40%">
\small
```scheme
(define (soma a b)
  (if (zero? b)
      a
      (add1
       (soma a (sub1 b)))))
```
</div>
<div class="column" width="10%">
</div>
<div class="column" width="50%">
\small

```
```

`(soma 4 3)`{.scheme} \pause \newline
`(add1 (soma 4 2))`{.scheme} \pause \newline
`(add1 (add1 (soma 4 1)))`{.scheme} \pause \newline
`(add1 (add1 (add1 (soma 4 0))))`{.scheme} \pause \newline
`(add1 (add1 (add1 4)))`{.scheme} \pause \newline
`(add1 (add1 5))`{.scheme} \pause \newline
`(add1 6)`{.scheme} \pause \newline
`7`{.scheme} \pause
</div>
</div>

\vspace{5mm}

Este é um **processo recursivo**. Ele é caracterizado por uma sequência de operações adiadas e tem um padrão de "cresce e diminui".


## Processos iterativos e recursivos
<div class="columns">
<div class="column" width="60%">
\small
```scheme
(define (soma-alt a b)
  (if (zero? b)
      a
      (soma-alt (add1 a) (sub1 b))))
```
</div>
<div class="column" width="30%">
\small

```
```

`(soma-alt 4 3)`{.scheme} \pause \newline
`(soma-alt 5 2)`{.scheme} \pause \newline
`(soma-alt 6 1)`{.scheme} \pause \newline
`(soma-alt 7 0)`{.scheme} \pause \newline
`7`{.scheme} \pause

</div>
</div>

\vspace{5mm}

Este é um **processo iterativo**. Nele o "espaço" necessário para fazer a substituição não depende do tamanho da entrada.


## Processos iterativos e recursivos

Na avaliação da expressão `(soma-alt 4 3)`{.scheme} no exemplo anterior, o valor de `a`{.scheme} foi usado como um acumulador, armazenando a soma parcial. \pause

O uso de acumulador neste problema reduziu o uso de memória.



Recursão em cauda
=================


## Recursão em cauda

Uma **chamada em cauda** é a chamada de uma função que acontece como última operação dentro de uma função. \pause

Uma **função recursiva em cauda** é aquela em que todas as chamadas recursivas são em cauda.


## Recursão em cauda

A forma de criar processos iterativos em linguagens funcionais é utilizando recursão em cauda. \pause

Os compiladores/interpretadores de linguagens funcionais otimizam as recursões em cauda de maneira que não é necessário manter a pilha das chamadas recursivas, o que torna a recursão tão eficiente quanto um laço em uma linguagem imperativa. Esta técnica é chamada de **eliminação da chamada em cauda**.



Projetando funções com acumuladores
===================================

## Projetando funções com acumuladores

Usar acumuladores é algo que fazemos **depois** que definimos a função e não antes. \pause

As etapas para projetar funções com acumuladores são \pause

- Identificar que a função se beneficia ou precisa de um acumulador \pause

    - Torna a função mais simples \pause
    - Diminui o tempo de execução \pause
    - Diminui o consumo de memória \pause

- Entender o que o acumulador significa e determinar \pause

    - A inicialização \pause
    - A atualização \pause

- Determinar o resultado da função a partir do acumulador


## Projetando funções com acumuladores

Vamos reescrever diversas funções utilizando acumuladores.


## Exemplo - tamanho

\small

```scheme
;; Lista -> Natural
;; Conta a quantidade de elementos de lst.
(examples
 (check-equal? (tamanho empty) 0)
 (check-equal? (tamanho (list 4)) 1)
 (check-equal? (tamanho (list 4 7)) 2)
 (check-equal? (tamanho (list 4 8 -4)) 3))

(define (tamanho lst)
  (cond
    [(empty? lst) 0]
    [else (add1 (tamanho (rest lst)))]))
```


## Exemplo - tamanho

Existe algum benefício em utilizar acumulador? \pause

Como o tamanho da resposta não depende do tamanho da entrada, esta função está usando mais memória do que é necessário, portanto ela pode beneficiar-se do uso de acumulador. \pause

Qual o significado do acumulador? \pause A quantidade de elementos já "vistos". \pause

Qual é o valor inicial do acumulador? \pause `0`{.scheme}. \pause

Como atualizar o acumulador? \pause Somando 1. \pause

Qual é a resposta da função? \pause O valor do acumulador.


## Exemplo - tamanho

\small

```scheme
(define (tamanho lst0)
  ;; acc - a quantidade de elementos de lst0 já visitados
  (define (iter lst acc)
    (cond
      [(empty? lst) acc]
      [else (iter (rest lst) (add1 acc))]))
  (iter lst0 0))
```


## Exemplo - soma

\small

```scheme
;; Lista(Número) -> Número
;; Soma os elementos de lst.
(examples
 (check-equal? (soma empty)0)
 (check-equal? (soma (list 3)) 3)
 (check-equal? (soma (list 3 5)) 8)
 (check-equal? (soma (list 3 5 -2)) 6))

(define (soma lst)
  (cond
    [(empty? lst) 0]
    [else (+ (first lst)
             (soma (rest lst)))]))
```


## Exemplo - soma

Existe algum benefício em utilizar acumulador? \pause

Como o tamanho da resposta não depende do tamanho da entrada, esta função está usando mais memória do que é necessário, portanto ela pode beneficiar-se do uso de acumulador. \pause

Qual o significado do acumulador? \pause A soma dos elementos já "vistos". \pause

Qual é o valor inicial do acumulador? \pause `0`{.scheme}. \pause

Como atualizar o acumulador? \pause Somando o primeiro da lista de entrada. \pause

Qual é a resposta da função? \pause O valor do acumulador.


## Exemplo - soma

\small

```scheme
(define (soma lst0)
  ;; acc - a soma dos elementos de lst0 já visitados
  (define (iter lst acc)
    (cond
      [(empty? lst) acc]
      [else (iter (rest lst) (+ (first lst) acc))]))
  (iter lst0 0))
```


## Exemplo - inverte

\small

```scheme
;; Lista -> Lista
;; Inverte a ordem dos elementos de lst.
(examples
 (check-equal? (inverte empty) empty)
 (check-equal? (inverte (list 2)) (list 2))
 (check-equal? (inverte (list 2 8 9)) (list 9 8 2)))

(define (inverte lst)
  (cond
    [(empty? lst) empty]
    [else (append (inverte (rest lst))
                  (list (first lst)))]))
```


## Exemplo - inverte

Existe algum benefício em utilizar acumulador? \pause

Neste caso a função é mais complicada do que o necessário. Isto porque o resultado da chamada recursiva é processada por outra função recursiva (`append`{.scheme}). \pause Além disso, o tempo de execução desta função é $\Theta(n^2)$, o que intuitivamente é muito para inverter uma lista. \pause

Qual o significado do acumulador? \pause Os elementos que já foram visitados em ordem reversa. \pause

Qual é o valor inicial do acumulador? \pause `empty`{.scheme}. \pause

Como atualizar o acumulador? \pause Colocando o primeiro da entrada como primeiro do acumulador. \pause

Qual é a resposta da função? \pause O valor do acumulador.


## Exemplo - inverte

\small

```scheme
(define (inverte lst0)
  ;; acc - os elementos já visitados de lst0 em ordem inversa
  (define (iter lst acc)
    (cond
      [(empty? lst) acc]
      [else (iter (rest lst)
                  (cons (first lst) acc))]))
  (iter lst0 empty))
```


Função `foldl`
============

## Função `foldl`

Vamos observar as semelhanças das funções `tamanho`{.scheme}, `soma`{.scheme} e `inverte`{.scheme}.


## Função `foldl`

```scheme
(define (tamanho lst0)
  (define (iter lst acc)
    (cond
      [(empty? lst) acc]
      [else (iter (rest lst) (add1 acc))]))
  (iter lst0 0))
```


## Função `foldl`

```scheme
(define (soma lst0)
  (define (iter lst acc)
    (cond
      [(empty? lst) acc]
      [else (iter (rest lst) (+ (first lst) acc))]))
  (iter lst0 0))
```


## Função `foldl`

```scheme
(define (inverte lst0)
  (define (iter lst acc)
    (cond
      [(empty? lst) acc]
      [else (iter (rest lst) (cons (first lst) acc))]))
  (iter lst0 empty))
```


## Função `foldl`

Vamos criar uma função chamada `reduz-acc`{.scheme} (pré-definida em Racket com o nome `foldl`{.scheme}) que abstrai este comportamento.


## Função `reduz-acc` / `foldl`

```scheme
;; (X Y -> Y) Y Lista(X) -> Y
;; A chamada
;; (reduz-acc f base (list x1 x2 ... xn) produz
;; (f xn ... (f x2 (f x1 base)))
(define (reduz-acc f base lst0)
  (define (iter lst acc)
    (cond
      [(empty? lst) acc]
      [else (iter (rest lst)
                  (f (first lst) acc))]))
  (iter lst0 base))
```


## Função `foldl`

Redefinimos as funções em termos de `reduz-acc`

```scheme
(define (tamanho lst)
  (reduz-acc (lambda (_ tam) (add1 tam))  0 lst))

(define (soma lst)
  (reduz-acc + 0 lst))

(define (inverte lst)
  (reduz-acc cons empty lst))
```



`foldr` vs `foldl`
==============

## `foldr` vs `foldl`

`foldr` e `foldl` produzem o mesmo resultado se a função `f` for associativa. \pause

Quando possível, utilize a função `foldl`, pois ela pode utilizar menos memória. \pause

Não tenha receio de utilizar a função `foldr`, muitas funções ficam mais complicadas, ou não podem ser escritas em termos de `foldl`, como por exemplo, `map` e `filter`.



Referências
===========

## Referências

Básicas

- Capítulos [31](https://htdp.org/2022-8-7/Book/part_six.html#%28part._ch~3aaccumulator-samples%29) e [32](https://htdp.org/2022-8-7/Book/part_six.html#%28part._sec~3adesign-accu%29) do livro [HTDP](http://htdp.org).

- Seção [1.2](https://mitpress.mit.edu/sicp/full-text/book/book-Z-H-11.html#%_sec_1.2) do livro [SICP](https://mitpress.mit.edu/sicp/).
