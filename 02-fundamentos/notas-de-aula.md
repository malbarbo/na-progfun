---
# vim: set spell spelllang=pt_br sw=4:
title: Fundamentos
# TODO: Discussão sobre if, and or serem formas especiais se avaliação aplicativa é usada e funções normais se avaliação em ordem normal é usada
# TODO: esclarecer o que é o modelo de substituição e adicionar perguntas/exercícios
# TODO: esclarecer o que é função composta
# TODO: rever as perguntas e melhorar as definições nos slides
# TODO: falar de estilo de código
# TODO: falar de tratamento de erro
# TODO: mudar a definição do paradigma funcional para redução de expressões para valores
# TODO: deixar para falar que o operador da combinação é uma expressão?
# TODO: mostrar diagrama de sintaxe?
---

Introdução
==========

## Introdução

O paradigma de programação funcional é baseado na definição e aplicação de funções. \pause

Uma **função** é uma conjunto de expressões que mapeia valores de entrada para valores de saída. \pause

Uma **expressão** é uma entidade sintática que quando avaliada (reduzida) produz um valor. \pause

Vamos ver uma sequência de definições de expressões e regras de avaliação.


## Definição de expressão (versão 0.1)

Uma **expressão** consiste de

- Um literal; ou

- Uma função primitiva \pause


Um **literal** é um valor que é representado diretamente no código. Em geral, os literais são utilizados para criar valores de tipos primitivos.

\pause

Um **função primitiva** é uma função suportada diretamente pela linguagem de programação.


## Literais de tipos primitivos

Gleam provê 9 tipos primitivos. \pause Todos os nomes de tipos começam com letra maiúscula. \pause

<div class="columns">
<div class="column" width="50%">
\small

Número inteiro (`Int`{.gleam}) \pause

- `1345`{.gleam} \pause
- `9_876`{.gleam} \pause

Números de ponto flutuante (`Float`{.gleam}) \pause

- `2.65`{.gleam}
- `2.0e12`{.gleam}
- `7.4e-10`{.gleam}

\pause

</div>
<div class="column" width="50%">
\small

Booleano (`Bool`{.gleam}) \pause

- `True`{.gleam}

- `False`{.gleam} \pause


Strings (`String`{.gleam})\pause

- `"din uem"`{.gleam} \pause

</div>
</div>

\ 

Veremos alguns outros tipos primitivos ao longo da disciplina.


## Funções primitivas

Gleam provê diversas operações primitivas, a maioria delas está disponível na forma de operadores. \pause Todos os nomes de funções começam com letra minúscula. \pause

<div class="columns">
<div class="column" width="50%">
\small

Operações com inteiros:

- `+ (int.add)`{.gleam}
- `- (int.subtract)`{.gleam}
- `* / % > >= < <= ==`{.gleam} \pause
- `int.to_float`{.gleam} e diversas outras no módulo `int`{.gleam}. \pause

Operações com floats:

- `*. (float.product)`{.gleam}
- `/. (float.divide)`{.gleam}
- `+. -.  >. >=. <. <=. ==`{.gleam} \pause
- `float.truncate`{.gleam} e diversas outras no módulo `float`{.gleam}. \pause

</div>
<div class="column" width="50%">
\small

Operações com strings:

- `<> (string.append)`{.gleam} \pause
- `==`{.gleam}
- `string.slice`{.gleam} e diversas outras no módulo `string`{.gleam}.

</div>
</div>


## Processo de avaliação de expressões (versão 0.1)

<div class="columns">
<div class="column" width="50%">
Uma **expressão** consiste de

- Um literal; ou

- Uma função primitiva

\pause
</div>
<div class="column" width="50%">
Regra para **avaliação de expressão** \pause

- Literal $\rightarrow$ valor que o literal representa

- Função primitiva $\rightarrow$ sequência de instruções de máquina associada com a função
</div>
</div>

\pause

Como a regra de avaliação de expressão está ligada com a definição de expressão? \pause

Uma expressão é definida em termos de dois casos e por isso a regra de avaliação de expressão também é definida por dois casos.


## Exemplo de avaliação de expressões

```gleam
> True
True
> 231
231
> "Banana"
"Banana"
> int.add
//fn(a, b) { ... }
```


## Expressões

A definição de expressão que acabamos de ver parece bastante limitada, o que está faltando? \pause

Uma forma de combinar expressões para formar novas expressões!



Combinações
===========

## Combinações

Alguns exemplos de combinações

<div class="columns">
<div class="column" width="50%">
\small

```gleam
> { 2 + 12 } * 5
70
> "Gol" <> string.repeat("!", 4)
"Gol!!!!"
```

</div>
<div class="column" width="50%">
\small

```gleam
> int.multiply(int.add(2, 12), 5)
70
> string.append("Gol",
                string.repeat("!", 4))
"Gol!!!"
```
</div>
</div>

\pause

Considerando apenas funções e literais (vamos deixar os operadores de lado), qual é forma de combinar expressões para criar novas expressões? \pause

A chamada de função. \pause

Como podemos definir como são formadas as chamadas de funções?


## Chamadas de funções

Primeira tentativa

Uma chamada de função começa com uma função primitiva, seguido de abre parêntese, seguido de um ou mais **literais** separados por vírgula, seguido de fecha parêntese.

\pause

Essa definição é adequada? \pause Não! \pause

O exemplo `int.multiply(int.add(2, 12), 5)`{.gleam} não está de acordo com essa definição! \pause

Segunda tentativa \pause

Uma chamada de função começa com uma função primitiva, seguido de abre parêntese, seguido de uma ou mais **expressões** separadas por vírgula, seguido de fecha parêntese. \pause

Vamos usar uma definição mais genérica.


## Chamadas de funções

Uma **chamada de função** consiste de uma **expressão** seguido por uma sequência de **expressões** entre parênteses separadas por vírgula. \pause

- A primeira expressão é a **operador**; \pause

- As demais expressões são os **operandos**. \pause

Qual é o valor produzido pela avaliação de uma chamada de função? \pause

- O resultado da aplicação do valor do operador aos valores dos operandos.


## Expressões

Vamos atualizar a definição de expressão para incluir as chamadas de funções.


## Definição de expressão (versão 0.2)

<div class="columns">
<div class="column" width="50%">
Uma **expressão** consiste de

- Um literal; ou

- Uma função primitiva; ou

- Uma chamada de função (**expressão** seguida de uma lista de **expressões** entre parênteses)

\pause
</div>
<div class="column" width="50%">
Regra para **avaliação de expressão** \pause

- Literal $\rightarrow$ valor que o literal representa \pause

- Função primitiva $\rightarrow$ sequência de instruções de máquina associada com a função \pause

- Chamada de função \pause

    - **Avalie cada expressão** da chamada da função, isto é, reduza cada expressão para um valor \pause

      $\rightarrow$ resultado da aplicação da função aos argumentos

</div>
</div>


## Definição de expressão (versão 0.2)

Algumas observações interessantes \pause

- Uma expressão é definida por três casos e a regra de avaliação também tem três casos. \pause

- Quando uma expressão é uma chamada de função, ela contém outras expressões. \pause Quando uma definição refere-se a si mesmo, dizemos que ela é uma definição com **autorreferência**. \pause O uso de autorreferência permite a criação de expressões de tamanhos arbitrários. \pause

- O processo de avaliação para uma expressão que é uma chamada de função requer a chamada do processo de avaliação para suas expressões. \pause Quando um processo é definido em termos de si mesmo, dizemos que ele é **recursivo**. \pause O uso de recursividade permite a avaliação de expressões expressões de tamanhos arbitrários. \pause

- Uma autorreferência em uma definição implicada (geralmente) em uma recursão para processar os elementos que seguem a definição.


## Definição de expressão (versão 0.2)

Estamos usando os conceitos de autorreferência e recursividade para entender o funcionamento da linguagem Gleam (a estrutura das linguagens de programação são recursivas), mas iremos ver que estes conceitos são fundamentais também para criar programas no paradigma funcional.


## Avaliação de expressões

<!-- TODO: fazer uma animação -->

Exemplo de avaliação de um expressão \pause

\small

`import gleam/int.{add, multiply as mul, subtract as sub}`{.gleam} \pause

`add(mul(3, add(mul(2, 4), add(3, 5))), add(sub(10, 7), 6))`{.gleam} \pause
`add(mul(3, add(mul(2, 4), add(3, 5))), add(sub(10, 7), 6)) // mul(2, 4) -> 8`{.gleam} \pause
`add(mul(3, add(8, add(3, 5))), add(sub(10, 7), 6))         // add(3, 5) -> 8`{.gleam} \pause
`add(mul(3, add(8, 8)), add(sub(10, 7), 6))                 // add(8, 8) -> 16`{.gleam} \pause
`add(mul(3, 16), add(sub(10, 7), 6))                        // mul(3, 16) -> 48`{.gleam} \pause
`add(48, add(sub(10, 7), 6))                                // sub(10, 7) -> 3`{.gleam} \pause
`add(48, add(3, 6))                                         // add(3, 6) -> 9`{.gleam} \pause
`add(48, 9)                                                 // add(48, 9) -> 57`{.gleam} \pause
`57`{.gleam}


## Definições

Vimos anteriormente que o paradigma de programação funcional é baseado na definição e aplicações de funções. \pause

Como funções são definidas em termos de expressões, nós vimos primeiramente o que são expressões. \pause

Agora vamos ver o que são definições e como fazer definições de novas funções.


Definições
==========

## Definições

Qual é o propósito das definições? \pause

Definições servem para dar nome a objetos computacionais, sejam dados ou funções. \pause

- É a forma de abstração mais elementar


## Definições de constantes

A forma geral para definições de constantes em Gleam é:

\small

```gleam
[pub] const nome [: Tipo] = literal
```

\pause

Exemplos

<div class="columns">
<div class="column" width="50%">
\small

```gleam
const x: Int = 10
pub const y = 20
```

\pause

</div>
<div class="column" width="50%">
\small

```gleam
> x
10
> y
20
```

</div>
</div>

\pause

\ 

Note que a especificação do tipo da constante é opcional. Se o tipo não for especificado, ele é inferido pelo compilador.


## Definições de funções

A forma geral para definições de novas funções (**funções compostas**) em Gleam é:

\small

```gleam
[pub] fn nome(parametro1 [: Tipo], parametro2 [: Tipo], ...) [-> Tipo] {
    expressao...
}
```

\pause

Exemplos

<div class="columns">
<div class="column" width="50%">
\small

```gleam
fn quadrado(x: Int) -> Int {
    x * x
}
pub fn soma_quadrados(a: Int, b) {
    quadrado(a) + quadrado(b)
}
```

\pause

</div>
<div class="column" width="50%">
\small

```gleam
> soma_quadrados(3, 4)
25
```

</div>
</div>

\pause

Note que a especificação dos tipo das entradas e saídas são opcionais. Se os tipos não forem especificado, ele são inferidos pelo compilador.


## Definições

Os nomes usados nas definições são associados com os objetos que eles representam e armazenados em um memória chamada de **ambiente**.


## Definições

Um programa em Gleam é composto por uma sequência de definições e instruções `import`{.gleam}. \pause

Agora precisamos estender a definição de expressões para incluir nomes e alterar a regra de avaliação de expressões para considerar a chamada de funções compostas.



Modelo de substituição
======================

## Definição de expressão (versão 0.3)

<div class="columns">
<div class="column" width="35%">
Uma **expressão** consiste de

- Um literal; ou
- Uma função primitiva; ou
- Um nome; ou
- Uma chamada de função (**expressão** seguida de uma lista de **expressões** entre parênteses)

\pause
</div>
<div class="column" width="60%">
Regra para **avaliação de expressão**

- Literal $\rightarrow$ valor que o literal representa
- Função primitiva $\rightarrow$ sequência de instruções de máquina associada com a função \pause
- Nome $\rightarrow$ valor associado com o nome no ambiente \pause
- Chamada de função
    - **Avalie cada expressão** da chamada da função \pause
    - Se o operador é uma função primitiva, aplique a função aos argumentos \pause
    - Senão (o operador é uma função composta) \pause, **avalie** o corpo da função **substituindo** cada ocorrência do parâmetro formal pelo argumento correspondente
</div>
</div>


## Modelo de substituição

Essa forma de calcular o resultado da aplicação de funções compostas é chamada de **modelo de substituição**.


## Modelo de substituição

\scriptsize

```gleam
fn quadrado(x) { x * x }
fn soma_quadrado(a, b) { quadrado(a) + quadrado(b) }
fn f(a) { soma_quadrados(a + 1, a * 2) }
```

```gleam
f(5)                          // Substitui f(5) pelo corpo de f com as ocorrências
                              // do parâmetro a  substituídas pelo argumento 5
```

\pause

`soma_quadrados(5 + 1, 5 * 2)  // Reduz 5 + 1 para o valor 6`{.gleam} \pause
`soma_quadrados(6, 5 * 2)      // Reduz 5 * 2 para o valor 10`{.gleam} \pause
`soma_quadrados(6, 10)         // Substitui soma_quadrados(6, 10) pelo corpo ...`{.gleam} \pause
`quadrado(6) + quadrado(10)    // Substitui quadrado(6) pelo corpo ...`{.gleam} \pause
`{ 6 * 6 } + quadrado(10)      // Reduz 6 * 6 para 36`{.gleam} \pause
`36 + quadrado(10)             // Substitui quadrado(10) pelo corpo ...`{.gleam} \pause
`36 + { 10 * 10 }              // Reduz 10 * 10 para 100`{.gleam} \pause
`36 + 100                      // Reduz 36 + 100 para 136`{.gleam} \pause \newline
`136`{.gleam}


## Modelo de substituição

Ao invés de avaliar os operandos e depois fazer a substituição, existe um outro modo de avaliação que primeiro faz a substituição e apenas avalia os operandos quando (e se) eles forem necessários. \pause

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

Observe que a resposta obtida foi a mesma do método anterior.


## Modelo de substituição

Este método de avaliação alternativo de primeiro substituir e depois reduzir, é chamado de **avaliação em ordem normal** (avaliação preguiçosa). \pause

O método de avaliação que primeiro avalia os argumentos e depois aplica a função é chamado de **avaliação em ordem aplicativa** (avaliação ansiosa). \pause

O Racket usa por padrão a avaliação em ordem aplicativa.

O Haskell usa a avaliação em ordem normal.


## Exercício

1. O seu amigo Alan está planejando uma viagem pro final do ano com a família e está considerando diversos destinos. Uma das coisas que ele está levando em consideração é o custo da viagem, que inclui, entre outras coisas, hospedagem, combustível e o pedágio. Para o cálculo do combustível ele pediu a sua ajuda, ele disse que sabe a distância que vai percorrer, o preço do litro do combustível e o rendimento do carro (quantos quilômetros o carro anda com um litro de combustível), mas que é muito chato ficar fazendo o cálculo manualmente, então ele quer que você faça um programa para calcular o custo do combustível em uma viagem.


## Solução exercício 1

O que de fato precisa ser feito? \pause

Calcular o custo do combustível (saída) em uma viagem sabendo a distância do percurso, o preço do litro do combustível e o rendimento do carro (entradas). \pause

Como determinar o processo (forma) que a saída é computada a partir da entrada? \pause

Fazendo exemplos específicos e generalizando o processo.


## Solução exercício 1

<div class="columns">
<div class="column" width="50%">
Exemplo de entrada

- Distância: 400 Km
- Preço do litro: R\$ 5
- Rendimento: 10 Km/l \pause

</div>
<div class="column" width="50%">

Saída \pause

- Quantidade de litros (Distância / Rendimento): $400 / 10 \rightarrow 40$ \pause
- Custo (Quantidade de litros $\times$ Preço do litro): $40 \times 5 \rightarrow 200$

</div>
</div>


## Solução exercício 1

Implementação \pause

```scheme
(define (custo-combustivel distancia preco-do-litro rendimento)
    (* (/ distancia rendimento) preco-do-litro))
```

\pause

Verificação \pause

Como verificar se a implementação faz o que é esperado? \pause

Executando os exemplos que fizemos anteriormente: \pause

```scheme
> (custo-combustivel 400 5 10)
200
```


## Exercício

2. Depois que você fez o programa para o Alan, a Márcia, amiga em comum de vocês, soube que você está oferecendo serviços desse tipo e também quer a sua ajuda. O problema da Márcia é que ela sempre tem que fazer a conta manualmente para saber se deve abastecer o carro com álcool ou gasolina. A conta que ela faz é verificar se o preço do álcool é até 70% do preço da gasolina, se sim, ela abastece o carro com álcool, senão ela abastece o carro com gasolina. Você pode ajudar a Márcia também?


## Solução exercício 1

É possível resolver este problema (produzindo uma resposta `"alcool"`{.scheme} ou `"gasolina"`{.scheme}) usando as coisas que vimos até aqui? \pause Não! \pause

O que está faltando? \pause Algum tipo de expressão condicional. \pause

Depois voltamos à esse problema!



Condicional
===========


## Condicional

Utilizamos a construção `if`{.scheme} para especificar expressões condicionais. Sua forma geral é

```scheme
(if <predicado> <consequente> <alternativa>)
```

\pause

Exemplos

```scheme
> (if (> 4 2) (+ 10 2) (* 7 3))
12
> (if (= 10 12) (+ 10 2) (* 7 3))
21
```


## Condicional

Qual a diferente do `if`{.scheme} do Racket em relação ao das outras linguagens? \pause

O `if`{.scheme} do Racket é uma expressão, ele produz um valor como resultado. Na maioria das outras linguagens o `if`{.scheme} é uma sentença, ele não produz um resultado mas gera uma mudança no estado do programa. \pause

O `if`{.scheme} é uma função? \pause Não. \pause

Se o `if`{.scheme} fosse uma função ele seria avaliado usando a regra de avaliação de funções, que diz que todas as expressões dos argumentos da função devem ser avaliados antes da aplicação na função. O `if`{.scheme} avalia o consequente ou a alternativa, dependendo da condição, mas não os dois. \pause

O `if`{.scheme} é uma **forma especial** e tem uma regra de avaliação específica. \pause (O Racket possui poucas formas especiais, isto significa que é possível aprender a sintaxe da linguagem rapidamente.)


## Regra de avaliação do `if`{.scheme}

Expressões `if`{.scheme} são avaliadas da seguinte maneira: \pause

- Se o predicado não é um valor, avalie o predicado e o substitua pelo seu valor \pause

- Se o predicado é `#t`{.scheme}, substitua toda a expressão `if`{.scheme} pelo consequente e avalie o consequente\pause

- Se o predicado é `#f`{.scheme}, substitua toda a expressão `if`{.scheme} pela alternativa e avalie a alternativa


## Exemplo

Vamos escrever uma função para calcular o valor absoluto de um número, isto é

$$\mathrm{abs}(x) = \begin{cases}
x & \text{se } x \ge 0 \\
-x & \text{caso contrário}
\end{cases}$$

e ver o processo de avaliação dessa função.


## Condicional

\small

```scheme
(define (abs x)
  (if (>= x 0)
      x
      (- x)))
```

\pause

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
(- -4)           ; Reduz (- -4) para 4 (não mostrado...)
```


## Definição de expressão (versão 1.0)

Vamos atualizar a nossa definição de expressão pra incluir formas especiais.


## Definição de expressão (versão 1.0)

<div class="columns">
<div class="column" width="35%">
Uma **expressão** consiste de

- Um literal; ou
- Uma função primitiva; ou
- Um nome; ou
- Uma forma especial; ou
- Uma combinação

\pause
</div>
<div class="column" width="60%">
Regra para **avaliação de expressão**

- Literal $\rightarrow$ valor que o literal representa
- Função primitiva $\rightarrow$ sequência de instruções de máquina associada com a função
- Nome $\rightarrow$ valor associado com o nome no ambiente
- Forma especial $\rightarrow$ avalie a forma especial usando a regra de avaliação específica
- Combinação
    - Avalie cada expressão da combinação
    - Se o operador é uma função primitiva, aplique a função aos argumentos
    - Senão (o operador é uma função composta), avalie o corpo da função substituindo cada ocorrência do parâmetro formal pelo argumento correspondente
</div>
</div>


## Condicional

A forma especial `cond`{.scheme} pode ser usada quando existem vários (pelo menos um) casos. \pause Por exemplo, podemos utilizar o `cond`{.scheme} ao invés de `if`{.scheme}s na função que determina o sinal de um número. \pause

<div class="columns">
<div class="column" width="50%">

```scheme
(define (sinal x)
  (if (> x 0)
      1
      (if (= x 0)
          0
          -1)))
```

</div>
<div class="column" width="50%">

```scheme
(define (sinal x)
  (cond
    [(> x 0) 1]
    [(= x 0) 0]
    [else -1]))
```

</div>
</div>


## Condicional

<div class="columns">
<div class="column" width="50%">
A forma geral do `cond`{.scheme} é

```scheme
(cond
  [<p1> <e1>]
  [<p2> <e2>]
  [<p3> <e3>]
  ...
  [else <en>])
```

</div>
<div class="column" width="50%">
\pause
Cada par `[<p> <e>]` é chamado de **cláusula** (parênteses e colchetes são equivalentes em Racket).

A primeira expressão de uma cláusula é chamada de **predicado** (expressão cujo o valor é interpretado como verdadeiro ou falso).

A segunda expressão de uma cláusula é chamada de **consequente**.
</div>
</div>


## Condicional

Expressões `cond`{.scheme} são avaliadas da seguinte maneira:

- Se o primeiro predicado não é um valor, avalie o predicado e o substitua pelo seu valor. Ou seja, substitua todo o `cond`{.scheme} por um novo `cond`{.scheme} onde o primeiro predicado foi substituído pelo seu valor

- Se o primeiro predicado é `#t`{.scheme} ou `else`{.scheme}, substitua a expressão `cond` inteira pelo primeiro consequente e avalie o consequente

- Se o primeiro predicado é `#f`{.scheme}, remova a primeira cláusula. Isto é, substitua o `cond`{.scheme} por um novo `cond`{.scheme} sem a primeira cláusula

- Se não tem mais cláusula, sinalize um erro


## Condicional

\scriptsize

<div class="columns">
<div class="column" width="50%">

```scheme
(define (sinal x)
  (cond
    [(> x 0) 1]
    [(= x 0) 0]
    [else -1]))
```

```scheme
(sinal 0)     ; Substitui (sinal 0) pelo corpo
              ; corpo da função...
```

\pause

```scheme
(cond
  [(> 0 0) 1] ; Como o primeiro predicado (> 0 0)
  [(= 0 0) 0] ; não é um valor, ele é avaliado
  [else -1]))
```

\pause

```scheme
(cond
  [#f 1]      ; Como o primeiro predicado é #f
  [(= 0 0) 0] ; a primeira cláusula é removida
  [else -1]))
```

</div>
<div class="column" width="50%">

\pause

```scheme
(cond
  [(= 0 0) 0] ; Como o primeiro predicado (= 0 0)
  [else -1])) ; não é um valor, ele é avaliado
```

\pause

```scheme
(cond
  [#t 0]      ; Como o primeiro predicado é #t
  [else -1])) ; o cond é substituído pelo consequente
              ; da primeira cláusula
```

\pause

```scheme
0
```

</div>
</div>


## Exercício

<div class="columns">
<div class="column" width="50%">

Defina a função `e-logico`{.scheme} que recebe os argumentos booleanos `x`{.scheme} e `y`{.scheme} e produz como resposta o e lógico entre eles, isto é \pause

```scheme
> (e-logico #f #f)
#f
> (e-logico #f #t)
#f
> (e-logico #t #f)
#f
> (e-logico #t #t)
#t
```

</div>
<div class="column" width="50%">

\pause

Observe o exemplos e responda: \pause

Se verificarmos o valor de `x`, e ele for `#t`{.scheme}, como calculamos o valor da função? \pause Verificando o valor de `y`, se for `#t`{.scheme}, o valor da função é `#t`{.scheme}, senão, o valor da função é `#f`{.scheme}. \pause

E se `x` não for `#t`{.scheme}? \pause O valor da função é `#f`{.scheme}. \pause

```scheme
(define (e-logico)
  (if (equal? x #t)
      (if (equal? y #t)
          #t
          #f)
      #f))
```

</div>
</div>


## Exercício

<div class="columns">
<div class="column" width="50%">

Podemos simplificar a função?

```scheme
(define (e-logico)
  (if (equal? x #t)
      (if (equal? y #t)
          #t
          #f)
      #f))
```

\pause

Sim!

\pause

A expressão `(equal? a #t)`{.scheme} produz o mesmo valor que a expressão `a`{.scheme} (desde que `a`{.scheme} seja booleano). \pause Portanto, podemos escrever \pause

</div>
<div class="column" width="50%">

```scheme
(define (e-logico)
  (if x
      (if y #t #f)
      #f))
```

\pause

Mais alguma simplificação? \pause Sim, a expressão `(if y #t #f)`{.scheme} é equivalente a expressão `y`{.scheme} (para `y` booleano). \pause Então, podemos escrever

```scheme
(define (e-logico x y)
  (if x y #f))
```

</div>
</div>


## Exercício

<div class="columns">
<div class="column" width="50%">

Defina a função `ou-logico`{.scheme} que recebe os argumentos booleanos `x`{.scheme} e `y`{.scheme} e produz como resposta o ou lógico entre eles, isto é \pause

```scheme
> (ou-logico #f #f)
#f
> (ou-logico #f #t)
#t
> (ou-logico #t #f)
#t
> (ou-logico #t #t)
#t
```

</div>
<div class="column" width="50%">

\pause

```scheme
(define (ou-logico x y)
  (if x #t y))
```

</div>
</div>


## Limitações

Existe alguma implicação em definirmos `e-logico` e `ou-logico` como funções? \pause

Sim, elas serão avaliadas como funções, ou seja, todos os argumentos são avaliados antes das funções serem avaliadas e isso impede que algumas otimizações sejam feitas. \pause Especificamente, na implementação do `e-logico`, se a primeira expressão for `#f`{.scheme}, não é necessário avaliar a segunda expressão. De forma semelhante, no `ou-logico`, se a primeira expressão for `#t`{.scheme}, não é necessário avaliar a segunda expressão. \pause

Essa otimização, chamada de **avaliação em curto-circuito**, é usada em outras linguagens e permitem escrever condições dependentes, como por exemplo `x != 0 e 10 / x == 2`{.c}, o que não é possível se todos os argumentos para o `e` são avaliados. \pause

Vamos ver em seguida que o `e` e o `ou` em Racket são formas especiais.


Operadores lógicos
==================

## Operadores lógicos

Predicados podem ser compostos usando as formas especiais `and`{.scheme} e `or`{.scheme} e a função `not`{.scheme}


## `not`

A função `(not expr)`{.scheme} produz `#t`{.scheme} quando `expr` é `#f`{.scheme}, e `#f`{.scheme} caso contrário

```scheme
> (not (> 5 2))
#f
> (not (< 5 2))
#t
```


## `and`

A forma geral do `and`{.scheme} é:

```scheme
(and <e1> ... <en>)
```


## `and`

Expressões `and`{.scheme} são avaliadas da seguinte maneira

- Se não existem expressões, produza `#t`{.scheme}

- Se a primeira expressão não é um valor, avalie a primeira expressão e a substitua pelo seu valor

- Se a primeira expressão é `#f`{.scheme}, produza `#f`{.scheme}

- Se a primeira expressão é `#t`{.scheme}, substitua a expressão `and`{.scheme} por uma nova expressão `and` sem a primeira expressão


- **Observação**: o passo a passo do Racket é um pouco diferente (não elimina os valores `#t`{.scheme})


## `and`

\small

```scheme
(and (> 4 2) #t (= 3 3))   ; A primeira expressão não é um valor, logo ela
                           ; é avalida e substiuída pelo seu valor
```

\pause

```scheme
(and #t #t (= 3 3))        ; A primeira expressão é #t, então
                           ; ela é removida do and
```

\pause

```scheme
(and #t (= 3 3))           ; A primeira expressão é #t, então ela é removida
```

\pause

```scheme
(and (= 3 3))              ; Reduz (= 3 3) para #t
```

\pause

```scheme
(and #t)                   ; A primeira expressão é #t, então ela é removida
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

A forma geral do `or`{.scheme} é:

```scheme
(or <e1> ... <en>)
```


## `or`

Expressões `or`{.scheme} são avaliadas da seguinte maneira

- Se não existem expressões, produza `#f`{.scheme}

- Se a primeira expressão não é um valor, avalie a primeira expressão e a substitua pelo seu valor

- Se a primeira expressão é `#t`{.scheme}, produza `#t`{.scheme}

- Se a primeira expressão é `#f`{.scheme}, substitua a expressão `or`{.scheme} por uma nova expressão `or`{.scheme} sem a primeira expressão


**Observação**: o passo a passo do Racket é um pouco diferente (não elimina os valores `#f`{.scheme})


## Operadores lógicos

\small

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

\pause

```scheme
#t
```



Igualdade
=========


## Igualdade

Igualdade é o conceito de determinar se dois valores são "iguais". \pause

É um conceito diferente de igualdade para números (função `=`{.scheme}, que verifica se dois valores são numericamente iguais). \pause

```scheme
    > (= 2 2.0)
    #t
```

\pause

As principais funções de igualdade em Racket são `equal?`{.scheme} e `eq?`{.scheme}.


## `equal?`

Cada tipo de objeto determina a sua implementação `equal?`{.scheme}, mas em geral, duas referências são `equal?`{.scheme} se elas referenciam o mesmo objeto, ou se o conteúdo dos objetos são os mesmos. \pause

Duas strings são `equal?`{.scheme} quando elas possuem o mesmo tamanho e contêm a mesma sequência de caracteres

```scheme
> (equal? (substring "banana" 1 4) (substring "cabana" 3 6))
#t
```


## `equal?`

Para estruturas que podem ser compostas, como listas, a função `equal?`{.scheme} checa a igualdade recursivamente \pause

```scheme
> (equal? (list 3 (list 4 2) 5) (list 3 (list 4 2) 5))
#t
> (equal? (list 3 2.0 1) (list 3 2 1))
#f
```


## `eq?`

A função `(eq? v1 v2)`{.scheme} produz `#t`{.scheme} se `v1` e `v2` referenciam o mesmo objeto, `#f`{.scheme} caso contrário. \pause `eq?`{.scheme} é avaliada rapidamente pois compara apenas as referências. \pause Entretanto, o `eq?`{.scheme} pode não ser adequado, pois a geração dos objetos pode não ser clara \pause

```scheme
> (eq? (+ 2 1) (- 5 2))
#t
> (eq? (expt 2 100) (expt 2 100))
#f
> (eq? (substring "banana" 1 4) (substring "cabana" 3 6))
#f
```


Referências
===========

## Referências

Básicas

- Capítulos [1 - Welcome to Racket](http://docs.racket-lang.org/guide/intro.html) e [2 - Racket Essentials](http://docs.racket-lang.org/guide/to-scheme.html) (2.1 e 2.2) do [Guia Racket](http://docs.racket-lang.org/guide/index.html)

- Capítulo [2 - Functions and Programs](https://htdp.org/2023-5-12/Book/part_one.html#%28part._ch~3afuncs-progs%29) (texto longo e detalhado) do livro [HTDP](https://htdp.org/2023-5-12/Book/index.html)

- Seção [1.1 - The Elements of Programming](https://web.mit.edu/6.001/6.037/sicp.pdf#section.1.1) (texto mais direto) do livro [SICP](https://web.mit.edu/6.001/6.037/sicp.pdf)


Complementares

- Capítulos [1](http://www.scheme.com/tspl4/intro.html#./intro:h0) e [2](http://www.scheme.com/tspl4/start.html#./start:h0) do livro [TSLP4](http://www.scheme.com/tspl4/)
