---
# vim: set spell spelllang=pt_br sw=4:
title: Fundamentos
toc: true
---

Introdução
==========

## Introdução

<!-- TODO: adicionar funções number->string number? (outras?) !-->
<!-- TODO: outros tipos pré-definidos? imagens? !-->
<!-- TODO: comentários: ; ;; #; !-->
<!-- TODO: falar de sexp !-->
<!-- TODO: explicar passo a passo como criar test-suite !-->

- O paradigma de programação funcional é baseado na definição e aplicação de
  funções

- As funções são escritas em termos de expressões

- Todas expressões produzem um resultado quando são avaliadas

- Mas o que são expressões e como o interpretador as avalia?


## Definição de expressão (versão 0.1)

- Uma expressão consiste de

    - Um literal; ou

    - Uma função primitiva


## Tipos primitivos

- Números

    - Exatos

        - Inteiros `1345`{.scheme}

        - Racionais `1/3`{.scheme}

        - Complexos com as partes real e imaginária exatas

    - Inexatos

        - Ponto flutuante `2.65`{.scheme}

        - Complexos com parte real ou imaginária inexata


## Tipos primitivos

- Booleano

    - `#t`{.scheme} verdadeiro

    - `#f`{.scheme} falso

- Strings

    - `"Seu nome"`{.scheme}

- Muitos outros tipos


## Funções primitivas

- Aritméticas: `+, -, *, /`{.scheme}

- Relacionais: `>, >=, <, <=, =`{.scheme}

- Strings: `string-length`{.scheme}, `string-append`{.scheme},
  `number->string`{.scheme}

- Muitas outras


## Processo de avaliação de expressões (versão 0.1)

- Literal $\rightarrow$ valor que o literal representa

- Função primitiva $\rightarrow$ sequência de instruções de máquina
  associada com a função


## Exemplo de avaliação de expressões

```scheme
> #t
#t
> 231
231
> "Banana"
"Banana"
> +
#<procedure:+>
```



Combinações
===========

## Combinações

- Uma expressão que representa uma função pode ser combinada com outras
  expressões para formar uma expressão que representa a aplicação da função
  a estas expressões

    ```scheme
    > (+ 12 56)
    68
    > (* 4 20)
    80
    > (> 4 5)
    #f
    > (string-append "Apenas " "um " "teste")
    "Apenas um teste"
    ```


## Combinações

- Este tipo de expressão é chamada de **combinação**


## Combinações

- Uma combinação consiste de uma lista de expressões entre parênteses

    - A expressão mais a esquerda é o **operador**

    - As outras expressões são os **operandos**

- O valor de uma combinação é obtido aplicando a função especificada pelo
  operador aos argumentos (valores dos operandos)


## Notação prefixa

- A convenção de colocar o operador a esquerda dos operandos é chamada de
  **notação prefixa**


## Vantagens da notação prefixa

- Funções podem receber um número variado de argumentos

    ```scheme
    > (* 2 8 10 1)
    160
    ```


## Vantagens da notação prefixa

- Combinações podem ser aninhadas facilmente, isto é, os elementos das
  combinações podem também ser combinações

    ```scheme
    > (+ (* 3 5) (- 10 6) 5)
    24
    > (+ (* 3
            (+ (* 2 4)
               (+ 3 5)))
         (+ (- 10 7)
            6))
    57
    ```


## Expressões

- Vamos atualizar a definição de expressão para incluir as combinações


## Definição de expressão (versão 0.2)

- Uma expressão consiste de

    - Um literal; ou

    - Uma função primitiva; ou

    - Uma combinação


## Processo de avaliação de expressões (versão 0.2)

- Literal $\rightarrow$ valor que o literal representa

- Função primitiva $\rightarrow$ sequência de instruções de máquina
  associada com a função

- Combinação

    - **Avalie cada expressão** da combinação, isto é, reduza cada
      expressão para um valor

    - Aplique a função aos argumentos


## Avaliação de expressões

- Observe que mesmo sendo um procedimento simples, ele pode ser usado para
  avaliar expressões muito complicadas (como por exemplo, expressões com muitos
  níveis de aninhamento)

- Isto é possível porque o procedimento é recursivo

- A recursão é uma ferramenta muito poderosa, e ela é essencial para a
  programação funcional


## Avaliação de expressões

<!-- TODO: fazer uma animação -->

\small

`(+ (* 3 (+ (* 2 4) (+ 3 5))) (+ (- 10 7) 6)) ; (* 2 4) -> 8`{.scheme}   \pause
`(+ (* 3 (+ 8 (+ 3 5))) (+ (- 10 7) 6))       ; (+ 3 5) -> 8`{.scheme}   \pause
`(+ (* 3 (+ 8 8)) (+ (- 10 7) 6))             ; (+ 8 8) -> 16`{.scheme}  \pause
`(+ (* 3 16) (+ (- 10 7) 6))                  ; (* 3 16) -> 48`{.scheme} \pause
`(+ 48 (+ (- 10 7) 6))                        ; (- 10 7) -> 3`{.scheme}  \pause
`(+ 48 (+ 3 6))                               ; (+ 3 6) -> 9`{.scheme}   \pause
`(+ 48 9)                                     ; (+48 9) -> 57`{.scheme}  \pause
`57`{.scheme}



Definições
==========

## Definições

- Definições servem para dar nome a objetos computacionais, sejam dados ou
  funções

- É a forma de abstração mais elementar


## Definições

- Em Racket, definições são feitas com o `define`

    ```scheme
    (define x 10)
    (define y (+ x 24))
    ```

    ```scheme
    > y
    34
    ```


## Definições

- Quando o interpretador encontra uma construção do tipo

    ```scheme
    (define <nome> <exp>)
    ```

    ele associa `<nome>` ao valor obtido pela avaliação de `<exp>`

- A avaliação de um nome resulta no objeto associado a ele na sua definição

- A memória que armazena as associações entre nomes e objetos é chamada de
  **ambiente**


## Definições

- O procedimento para avaliação de expressão não serve para definições

    - `(define x 10)`{.scheme} não significa aplicar a função `define`{.scheme}
      a dois argumentos

    - O propósito do `define`{.scheme} é associar o valor `10`{.scheme}
      ao nome `x`{.scheme}

    - Ou seja, `(define x 10)`{.scheme} não é uma combinação


## Definições

- Exceções à regra geral de avaliação de expressões são chamadas de **formas
  especiais**

    - `define`{.scheme} é uma forma especial

- Cada forma especial tem a sua própria regra de avaliação

- O Racket possui poucas formas especiais, isto significa que é possível
  aprender a sintaxe da linguagem rapidamente


## Definições

- Também é possível criar definições de novas funções (chamadas de **funções
  compostas**)

- A sintaxe geral é

    ```scheme
    (define (<nome> <parametros>) <corpo>)
    ```


## Definições

```scheme
(define (quadrado x)
  (* x x))
(define (soma-quadrados a b)
  (+ (quadrado a) (quadrado b)))

```

\pause

```scheme
> (quadrado 5)
25
> (quadrado (+ 2 6))
64
> (soma-quadrados (+ 2 2) 3)
25
```


## Definições

- Observe que as funções compostas (definidas pelo usuário) são usadas da mesma
  forma que as funções pré-definidas



Modelo de substituição
======================

## Modelo de substituição

- A definição e o processo de avaliação de expressões devem ser estendidos para
  comportar formas especiais e o uso de nomes definidos pelo usuário


## Definição de expressão (versão 0.3)

- Uma expressão consiste de

    - Um literal; ou

    - Uma função primitiva; ou

    - Um nome; ou

    - Uma forma especial; ou

    - Uma combinação


## Processo de avaliação de expressões (versão 0.3)

\small

- Literal $\rightarrow$ valor que o literal representa

- Função primitiva $\rightarrow$ sequência de instruções de máquina
  associada com a função

- Nome $\rightarrow$ valor associado com o nome no ambiente

- Forma especial $\rightarrow$ usar a regra específica de cada forma
  especial

- Combinação

    - Avalie cada expressão da combinação

    - Se o operador é uma função composta, avalie o corpo da função
      composta **substituindo** cada ocorrência do parâmetro formal pelo
      argumento correspondente

    - Senão, aplique a função primitiva aos argumentos


## Modelo de substituição

- Essa forma de aplicar funções compostas é chamada de **modelo de
  substituição**


## Modelo de substituição

\scriptsize

```scheme
(define (quadrado x)
  (* x x))
(define (soma-quadrados a b)
  (+ (quadrado a) (quadrado b)))
(define (f a)
  (soma-quadrados (+ a 1) (* a 2)))
```

```scheme
(f 5)                           ; Substitui (f 5) pelo corpo de f com
                                ; as ocorrências do parâmetro a
                                ; substituídas pelo argumento 5
```
`(soma-quadrados (+ 5 1) (* 5 2)); Reduz (+ 5 1) para o valor 6`{.scheme} \pause
`(soma-quadrados 6 (* 5 2))      ; Reduz (* 5 2) para o valor 10`{.scheme} \pause
`(soma-quadrados 6 10)           ; Subs (soma-quadrados 6 10) pelo corpo ...`{.scheme} \pause
`(+ (quadrado 6) (quadrado 10))  ; Subs (quadrado 6) pelo corpo ...`{.scheme} \pause
`(+ (* 6 6) (quadrado 10))       ; Reduz (* 6 6) para 36 \pause`{.scheme}
`(+ 36 (quadrado 10))            ; Subs (quadrado 10) pelo corpo ...`{.scheme} \pause
`(+ 36 (* 10 10))                ; Reduz (* 10 10) para 100`{.scheme} \pause
`(+ 36 100)                      ; Reduz (+ 36 100) para 136`{.scheme} \pause \newline
`136`{.scheme}


## {.standout}

\vspace{1cm}
\begin{tikzpicture}
    \node at (0, 0) {\includegraphics[width=\textwidth]{imagens/drracket-step.pdf}};
    \draw[line width=1pt,red] (-5.36cm, -3.41cm) rectangle ++(2cm, 0.36cm);
    \draw[line width=1pt,red] (-5.36cm, 2.26cm) rectangle ++(2.2cm, 0.35cm);
    \draw[line width=1pt,red] (2.4cm, 2.67cm) rectangle ++(0.9cm, 0.36cm);
\end{tikzpicture}


## Modelo de substituição

- Ao invés de avaliar os operandos e depois fazer a substituição, existe um
  outro modo de avaliação que primeiro faz a substituição e apenas avalia os
  operandos quando (e se) eles forem necessários

    \scriptsize

    ```scheme
    (f 5)
    (soma-quadrados (+ 5 1) (* 5 2))
    (+ (quadrado (+ 5 1)) (quadrado (* 5 2)))
    (+ (* (+ 5 1) (+ 5 1)) (* (* 5 2) (* 5 2)))
    (+ (* 6 (+ 5 1)) (* (* 5 2) (* 5 2)))
    (+ (* 6 6) (* (* 5 2) (* 5 2)))
    (+ 36 (* (* 5 2) (* 5 2)))
    (+ 36 (* 10 (* 5 2)))
    (+ 36 (* 10 10))
    (+ 36 100)
    136
    ```

\normalsize

- Observe que a resposta obtida foi a mesma do método anterior


## Modelo de substituição

- Este método de avaliação alternativo de primeiro substituir e depois reduzir,
  é chamado de **avaliação em ordem normal** (que é um tipo de avaliação
  atrasada)

- O método de avaliação que primeiro avalia os argumentos e depois aplica
  a função é chamado de **avaliação em ordem aplicativa**

- O Racket usa por padrão a avaliação em ordem aplicativa

- O Haskell usa avaliação em ordem normal



Condicional
===========

## Condicional

- Vamos escrever uma função para calcular o valor absoluto de um número, isto é

$$
\mathrm{abs}(x) = \begin{cases}
x & \text{se } x \ge 0 \\\\
-x & \text{caso contrário}
\end{cases}
$$

## Condicional

- A forma especial `if`{.scheme} é utilizada para especificar funções deste
  tipo. Sua forma geral é

    ```scheme
    (if <predicado> <consequente> <alternativa>)
    ```


## Condicional

- Expressões `if`{.scheme} são avaliadas da seguinte maneira

    - Se o predicado não é um valor, avalie o predicado e o substitua pelo seu
      valor

    - Se o predicado é `#t`{.scheme}, substitua toda a expressão `if`{.scheme}
      pelo consequente

    - Se o predicado é `#f`{.scheme}, substitua toda a expressão `if`{.scheme}
      pela alternativa


## Condicional

\scriptsize

```scheme
(define (abs x)
  (if (>= x 0)
      x
      (- x)))
```

```scheme
(abs -4)         ; Substitui (abs -4) pelo corpo ...
```

\pause

```scheme
(if (>= -4 0)    ; Como o predicado não é um valor,
    -4           ; a expressão (>= -4 0) é avaliada e
    (- -4))      ; substituída pelo seu valor
```

\pause

```scheme
(if #f           ; Como o predicado é #f, a expressão if
    -4           ; é substituída pela alternativa
    (- -4))      ;
```

\pause

```scheme
(- -4)           ; Reduz (- -4) para 4
```

\pause

```scheme
4
```


## Condicional

- A forma especial `cond` pode ser usada quando existem vários (pelo menos um)
  casos

    ```scheme
    (define (abs x)
      (cond
        [(>= x 0) x]
        [(< x 0) (- x)]))
    ```


## Condicional

- Como as duas condições são mutuamente excludentes, podemos usar o `else`

    ```scheme
    (define (abs x)
      (cond
        [(>= x 0) x]
        [else (- x)]))
    ```


## Condicional

\small

- A forma geral do `cond` é

    ```scheme
    (cond
      [<p1> <e1>]
      [<p2> <e2>]
      [<p3> <e3>]
      ...
      [else <en>])
    ```

- Cada par `[<p> <e>]` é chamado de **cláusula** (parênteses e colchetes são
  equivalentes em Racket)

- A primeira expressão de uma cláusula é chamada de **predicado** (expressão
  cujo o valor é interpretado como verdadeiro ou falso)

- A segunda expressão de uma cláusula é chamada de **consequente**


## Condicional

- Expressões `cond`{.scheme} são avaliadas da seguinte maneira

    - Se o primeiro predicado não é um valor, avalie o predicado e o substitua
      pelo seu valor. Ou seja, substitua todo o `cond`{.scheme} por um novo
      `cond`{.scheme} onde o primeiro predicado foi substituído pelo seu valor

    - Se o primeiro predicado é `#t`{.scheme} ou `else`{.scheme}, substitua
      a expressão `cond` inteira pelo primeiro consequente

    - Se o primeiro predicado é `#f`{.scheme}, remova a primeira cláusula. Isto
      é, substitua o `cond`{.scheme} por um novo `cond`{.scheme} sem a primeira
      cláusula

    - Se não tem mais cláusula, sinalize um erro


## Condicional

\scriptsize

```scheme
(define (abs x)
  (cond
    [(>= x 0) x]
    [else (- x)]))
```

```scheme
(abs -4)         ; Substitui (abs -4) pelo corpo ...
```

\pause

```scheme
(cond            ; Como o primeiro predicado não é um valor,
  [(>= -4 0) -4] ; a expressão (>= -4 0) é avaliada
  [else (- -4)]) ; e substituída pelo seu valor
```

\pause

```scheme
(cond            ; Como o primeiro predicado é falso, a primeira
  [#f -4]        ; cláusula é removida
  [else (- -4)]) ;
```

\pause

```scheme
(cond            ; Como o primeiro predicado é else,
  [else (- -4)]) ; o cond é substituído pelo primeiro consequente
```

\pause

```scheme
(- -4)           ; Reduz (- -4) para 4
```

\pause

```scheme
4
```


## Exercício

Defina as funções `e-logico` e `ou-logico` de tal forma que para os argumentos
x e y:

`(e-logico x y)` $\rightarrow$ `x` $\wedge$ `y`

`(ou-logico x y)` $\rightarrow$ `x` $\vee$ `y`

\pause

```scheme
(define (e-logico x y)
  (if x
    y
    #f))

(define (ou-logico x y)
  (if x
    #t
    y))
```



Operadores lógicos
==================

## Operadores lógicos

- Predicados podem ser compostos usando as formas especiais `and`{.scheme}
  e `or`{.scheme} e a função `not`{.scheme}


## `not`

- A função `(not <e>)`{.scheme} produz `#t`{.scheme} quando `<e>` for avaliado
  para um valor falso, e `#f`{.scheme} caso contrário

    ```scheme
    > (not (> 5 2))
    #f
    > (not (< 5 2))
    #t
    ```


## `and`

- A forma geral do `and`{.scheme} é:

    ```scheme
    (and <e1> ... <en>)
    ```


## `and`

- Expressões `and`{.scheme} são avaliadas da seguinte maneira

    - Se não existem expressões, produza `#t`{.scheme}

    - Se a primeira expressão não é um valor, avalie a primeira expressão
      e a substitua pelo seu valor

    - Se a primeira expressão é `#f`{.scheme}, produza `#f`{.scheme}

    - Se a primeira expressão é `#t`{.scheme}, substitua a expressão
      `and`{.scheme} por uma nova expressão `and` sem a primeira expressão


- **Observação**: o passo a passo do Racket é um pouco diferente (não elimina
  os valores `#t`{.scheme})


## `and`

\scriptsize

```scheme
(and (> 4 2) #t (= 3 3))   ; A primeira expressão não é um valor,
                           ; logo ela é avalida e substiuída pelo
                           ; seu valor
```

\pause

```scheme
(and #t #t (= 3 3))        ; A primeira expressão é #t, então
                           ; ela é removida do and
```

\pause

```scheme
(and #t (= 3 3))           ; A primeira expressão é #t, então
                           ; ela é removida do and
```

\pause

```scheme
(and (= 3 3))              ; Reduz (= 3 3) para #t
```

\pause

```scheme
(and #t)                   ; A primeira expressão é #t, então
                           ; ela é removida do and
```

\pause

```scheme
(and )                     ; Não tem mais expressões, produz #t
```

\pause

```scheme
#t
```


## `or`

- A forma geral do `or`{.scheme} é:

    ```scheme
    (or <e1> ... <en>)
    ```


## `or`

- Expressões `or`{.scheme} são avaliadas da seguinte maneira

    - Se não existem expressões, produza `#f`{.scheme}

    - Se a primeira expressão não é um valor, avalie a primeira expressão e a
      substitua pelo seu valor

    - Se a primeira expressão é `#t`{.scheme}, produza `#t`{.scheme}

    - Se a primeira expressão é `#f`{.scheme}, substitua a expressão
      `or`{.scheme} por uma nova expressão `or`{.scheme} sem a primeira
      expressão

- **Observação**: o passo a passo do Racket é um pouco diferente (não elimina
  os valores `#f`{.scheme})


## Operadores lógicos

\scriptsize

```scheme
(or (< 4 2) #t (= 3 3))  ; A primeira expressão não é um valor,
                         ; logo ela é avalida e substituída pelo
                         ; seu valor
```

\pause

```scheme
(or #f #t (= 3 3))       ; A primeira expressão é #f, então
                         ; ela é removida do or
```

\pause

```scheme
(or #t (= 3 3))          ; A primeira expressão é #t; produz #t
```

```scheme
#t
```



Operadores de equivalência
==========================


## Operadores de equivalência

- São utilizados para verificar a relação de equivalência entre expressões

- Não devem ser confundidos com o comparador `=`{.scheme}, utilizado apenas
  para valores numéricos

- Os principais operadores de equivalência são o `eq?`{.scheme},
  `eqv?`{.scheme} e `equal?`{.scheme}


## Operador `eq?`

- A função `(eq? v1 v2)`{.scheme} produz `#t`{.scheme} se `v1` e `v2`
  referenciam o mesmo objeto, `#f`{.scheme} caso contrário


## Operador `eq?`

- `eq?`{.scheme} é avaliada rapidamente pois compara apenas as referências

- Entretanto, o `eq?`{.scheme} pode não ser adequado, pois a geração dos
  objetos pode não ser clara

    \scriptsize

    ```scheme
    > (eq? 2 2)
    #t
    > (eq? (+ 3 5) (+ 5 3))
    #t
    > (eq? 2 2.0)
    #f
    > (eq? (expt 2 100) (expt 2 100))
    #f
    > (eq? (integer->char 955) (integer->char 955))
    #f
    ```

\normalsize

- Observe que nos três últimos exemplos, objetos distintos foram criados para
  expressões avaliadas para um mesmo valor


## Operador `eqv?`

- Dois valores são `eqv?`{.scheme} *sse* eles são `eq?`{.scheme}, exceto para números e
  caracteres


## Operador `eqv?`

- Dois números são `eqv?`{.scheme} se eles são precisamente iguais

    ```scheme
    > (eqv? (expt 2 100) (expt 2 100))
    #t
    > (eqv? 2 2.0)
    #f
    ```


## Operador `eqv?`

- Dois caracteres são `eqv?`{.scheme} quando seus resultados de
  `char->integer`{.scheme} forem iguais

    ```scheme
    > (eqv? (integer->char 955) (integer->char 955))
    #t
    > (eqv? #\a #\z)
    #f
    ```


## Operador `eqv?`

- Dois pares iguais não são `eqv?`{.scheme} entre si (recai ao `eq?`{.scheme})

    ```scheme
    > (eqv? (cons 1 2) (cons 1 2))
    #f
    ```


## Operador `equal?`

- Dois valores são `equal?`{.scheme} *sse* eles são `eqv?`{.scheme}, a menos
  que especificado de outra forma para um tipo de dado particular


## Operador `equal?`

- Duas strings são `equal?`{.scheme} quando elas possuem o mesmo tamanho
  e contêm a mesma sequência de caracteres

    ```scheme
    > (equal? "banana" "banana")
    #t
    > (equal? "banana" "abacaxi")
    #f
    ```


## Operador `equal?`

- Para estruturas que podem ser compostas, como pares, vetores e etc,
  o operador `equal?`{.scheme} checa a equivalência recursivamente

    ```scheme
    > (equal? (list 3 (list 4 2) 5) (list 3 (list 4 2) 5))
    #t
    > (equal? (list 3 2.0 1) (list 3 2 1))
    #f
    ```



Como projetar funções
=====================


## Como projetar funções

- Vamos utilizar as receitas de projeto do livro [How to Design
  Programs](http://htdp.org) para escrever funções

- Estas receitas de projeto permitem o projeto sistemático de funções

- Este processo pode não ser relevante para problemas simples, mas é essencial
  para os demais problemas

- Seja paciente e em breve você verá a utilidade deste processo

- Vamos treinar com problemas simples, para depois utilizar o processo em
  outros problemas


## Como projetar funções

1. Assinatura, propósito e cabeçalho

2. Exemplos

3. Modelo

4. Código do corpo da função

5. Teste e depuração


## Como projetar funções

- Cada etapa depende da anterior, mas às vezes pode ser necessário mudar a
  ordem

- Por exemplo, talvez você faça primeiro os exemplos para entender melhor o
  problema e poder escrever a assinatura e o propósito

- Às vezes você está escrevendo o corpo e encontra uma nova condição e deve
  voltar e alterar o propósito e os exemplos

- Mas você nunca deve escrever o código diretamente


## Como projetar funções

- Um modelo contém a estrutura básica que uma função deve ter, independente dos
  seu detalhes

- Em muitos casos o modelo de uma função é determinado pelos tipos de dados dos
  seus parâmetros. Este tipo de modelo é chamado de modelo dirigido por dados

- Para tipos atômicos (números, string, booleans) usamos o modelo:

    ```scheme
    (define (fun-for-atomic a)
        (... a))
    ```

- Para outros tipos, vamos construir o modelo com a definição do tipo


## Exemplo 2.1

Defina uma função que calcule o dobro de um dado valor.


## Exemplo 2.1

- Passo 1: Assinatura, propósito e cabeçalho

    ```scheme
    ;; Número -> Número
    ;; Produz o dobro de n.
    (define (dobro n) 0)
    ```

- Convenções:

    - Nome do tipo usando CamelCase

    - Nome da função em minúsculo usando `-` para separar as palavras


## Exemplo 2.1

- Passo 2: Exemplos

    ```scheme
    ;; Número -> Número
    ;; Produz o dobro de n.
    (check-equal? (dobro 0) 0)
    (check-equal? (dobro 4) 8)
    (check-equal? (dobro -2) -4)

    (define (dobro n) 0)
    ```


## Exemplo 2.1

- Passo 3: Modelo

- Como o parâmetro é um número, usamos o modelo para tipos atômicos

    ```scheme
    ;; Número -> Número
    ;; Produz o dobro de n.
    (check-equal? (dobro 0) 0)
    (check-equal? (dobro 4) 8)
    (check-equal? (dobro -2) -4)
    ;(define (dobro n) 0)

    (define (fun-for-atomic a)
        (... a))
    ```


## Exemplo 2.1

- Passo 3: Modelo

- Ajustamos os nomes no modelo para a função que estamos definindo

    ```scheme
    ;; Número -> Número
    ;; Produz o dobro de n.
    (check-equal? (dobro 0) 0)
    (check-equal? (dobro 4) 8)
    (check-equal? (dobro -2) -4)
    ;(define (dobro n) 0)

    (define (dobro n)
        (... n))
    ```


## Exemplo 2.1

- Passo 4: Código do corpo da função

- Baseado nos passos anteriores, escrevemos o corpo da função

    ```scheme
    ;; Número -> Número
    ;; Produz o dobro de n.
    (check-equal? (dobro 0) 0)
    (check-equal? (dobro 4) 8)
    (check-equal? (dobro -2) -4)
    ;(define (dobro n) 0)

    (define (dobro n)
        (* 2 n))
    ```


## Exemplo 2.1

Programa completo

\small

```scheme
#lang racket

(require rackunit)
(require rackunit/text-ui)

;; Número -> Número
;; Produz o dobro de n.
(define dobro-tests
  (test-suite
   "dobro tests"
   (check-equal? (dobro 0) 0)
   (check-equal? (dobro 4) 8)
   (check-equal? (dobro -2) -4)))
;; continua ...
```


## Exemplo 2.1

\small

```scheme
;; continuação
(define (dobro n)
  (* 2 n))

;; Teste ... -> Void
;; Executa um conjunto de testes.
(define (executa-testes . testes)
  (run-tests (test-suite "Todos os testes" testes))
  (void))

;; Chama a função para executar os testes.
(executa-testes dobro-tests)
```


## Exemplo 2.1

- Passo 5: Teste e depuração

  - \keys{\ctrl + r} ou \keys{F5} para executar o programa (e os testes)

- Resultado

    ```text
    3 success(es) 0 failure(s) 0 error(s) 3 test(s) run
    ```


## Exemplo 2.2

Defina uma função que verifique se um número é par.


## Exemplo 2.3

Defina uma função que encontre a maior palavra entre duas palavras dadas.


Referências
===========

## Referências básicas

- [Vídeos BSL](https://www.youtube.com/playlist?list=PL6NenTZG6Krqu5RRQi3TUGc605rrGGGWw)

- [How to Desgin Functions](https://class.coursera.org/programdesign-002/wiki/view?page=HtDFunctions)
  (Necessário inscrever-se no curso)

- [Vídeos How to Design  Functions](https://www.youtube.com/playlist?list=PL6NenTZG6KroMpbQDFNmv6YuydU1DTklw)

- [Introdução rápida ao Racket](http://docs.racket-lang.org/quick/index.html)

- Capítulos [1](http://docs.racket-lang.org/guide/intro.html)
    e [2](http://docs.racket-lang.org/guide/to-scheme.html) (2.1 e 2.2) do
    [Guia Racket](http://docs.racket-lang.org/guide/index.html)

- Seção
    [1.1](https://mitpress.mit.edu/sicp/full-text/book/book-Z-H-10.html#%_sec_1.1)
    do livro [SICP](https://mitpress.mit.edu/sicp/)


## Referências complementares

- Capítulos [1](http://www.scheme.com/tspl4/intro.html#./intro:h0)
    e [2](http://www.scheme.com/tspl4/start.html#./start:h0) do livro
    [TSLP4](http://www.scheme.com/tspl4/)
