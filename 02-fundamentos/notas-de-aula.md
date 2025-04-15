---
# vim: set spell spelllang=pt_br sw=4:
title: Fundamentos
# TODO: Discussão sobre if, and or serem formas especiais se avaliação aplicativa é usada e funções normais se avaliação em ordem normal é usada
# TODO: esclarecer o que é o modelo de substituição e adicionar perguntas/exercícios
# TODO: esclarecer o que é função composta
# TODO: rever as perguntas e melhorar as definições nos slides
# TODO: falar de estilo de código
# TODO: falar de tratamento de erro?
# TODO: mudar a definição do paradigma funcional para redução de expressões para valores?
# TODO: não falar que o operador da chamada de função é uma expressão?
# TODO: mostrar diagrama de sintaxe?
# TODO: falar das prioridades dos operadores e {} para agrupamento?
# TODO: exemplos de avalição de and e or?
# TODO: falar da forma de operadores binários
# TODO: falar que cada expressão tem um tipo
---

Introdução
==========

## Introdução

O paradigma de programação funcional é baseado na definição e aplicação de funções. \pause

Uma **função** é um conjunto de expressões que mapeia valores de entrada para valores de saída. \pause

Uma **expressão** é uma entidade sintática que quando avaliada (reduzida) produz um valor. \pause

Vamos ver uma sequência de definições de expressões e regras de avaliação.


## Definição de expressão (versão 0.1)

Uma **expressão** consiste em

- Um literal; ou

- Uma função primitiva \pause


Um **literal** é um valor que é representado diretamente no código. Em geral, os literais são utilizados para criar valores de tipos primitivos.

\pause

Um **tipo primitivo** é um tipo suportado diretamente pela linguagem de programação.

\pause

Uma **função primitiva** é uma função suportada diretamente pela linguagem de programação.


## Literais de tipos primitivos

Gleam provê 9 tipos primitivos. \pause Todos os nomes de tipos começam com letra maiúscula. \pause

<div class="columns">
<div class="column" width="50%">
\small

Número inteiro (`Int`{.gleam})

- `1345`{.gleam}
- `9_876`{.gleam}

\pause

Números de ponto flutuante (`Float`{.gleam}) \pause

- `2.65`{.gleam}
- `2.0e12`{.gleam}
- `7.4e-10`{.gleam}

\pause

</div>
<div class="column" width="50%">
\small

Booleano (`Bool`{.gleam})

- `True`{.gleam}
- `False`{.gleam}

\pause

Strings (`String`{.gleam})

- `"din uem"`{.gleam}
- `"apenas \"um\" teste"`{.gleam}

\pause

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
- `* / % > >= < <= == !=`{.gleam} \pause
- `int.to_float`{.gleam} e diversas outras no módulo [`int`{.gleam}](https://hexdocs.pm/gleam_stdlib/gleam/int.html).

\pause

Operações com floats:

- `*. (float.product)`{.gleam}
- `/. (float.divide)`{.gleam}
- `+. -.  >. >=. <. <=. == !=`{.gleam} \pause
- `float.truncate`{.gleam} e diversas outras no módulo [`float`{.gleam}](https://hexdocs.pm/gleam_stdlib/gleam/float.html).

\pause

</div>
<div class="column" width="50%">
\small

Operações com strings:

- `<> (string.append)`{.gleam} \pause
- `== !=`{.gleam}
- `string.slice`{.gleam} e diversas outras no módulo [`string`{.gleam}](https://hexdocs.pm/gleam_stdlib/gleam/string.html).

\ 

\pause

Operações com booleanos:

- `! (bool.negate)`{.gleam} \pause
- `== !=`{.gleam}
- Outros operadores que veremos depois.

</div>
</div>


## Processo de avaliação de expressões (versão 0.1)

<div class="columns">
<div class="column" width="50%">
Uma **expressão** consiste em

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

\small

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
```

</div>
<div class="column" width="50%">
\small

```gleam
> int.multiply(int.add(2, 12), 5)
70
```
</div>
</div>

\pause

<div class="columns">
<div class="column" width="50%">
\small

```gleam
> "Gol" <> string.repeat("!", 4)
"Gol!!!!"
```

</div>
<div class="column" width="50%">
\small

```gleam
> string.append("Gol",
                string.repeat("!", 4))
"Gol!!!"
```
</div>
</div>

\pause

<div class="columns">
<div class="column" width="50%">
\small

```gleam
> 10 / 0  // Divisão por zero é zero!
0
```

</div>
<div class="column" width="50%">
\small

```gleam
> int.divide(10, 0)
0
```
</div>
</div>

\pause

\ 

Considerando apenas funções e literais (vamos deixar os operadores de lado por simplicidade), qual é forma de combinar expressões para criar novas expressões? \pause

A chamada de função. \pause Como podemos definir como são formadas as chamadas de funções?


## Chamadas de funções

Primeira tentativa

Uma chamada de função começa com uma função primitiva, seguida de abre parêntese, seguido de uma sequência de **literais** separados por vírgula, seguida de fecha parêntese.

\pause

Essa definição é adequada? \pause Não! \pause

O exemplo `int.multiply(int.add(2, 12), 5)`{.gleam} não está de acordo com essa definição! \pause

Segunda tentativa \pause

Uma chamada de função começa com uma função primitiva, seguida de abre parêntese, seguido de uma sequência de **expressões** separadas por vírgula, seguida de fecha parêntese. \pause

Vamos usar uma definição mais genérica.


## Chamadas de funções

Uma **chamada de função** consiste em uma **expressão** seguida por uma sequência de **expressões** entre parênteses separadas por vírgula. \pause

- A primeira expressão é o **operador**; \pause

- As demais expressões são os **operandos**. \pause

Qual é o valor produzido pela avaliação de uma chamada de função? \pause

- O resultado da aplicação do valor do operador aos valores dos operandos.


## Expressões

Vamos atualizar a definição de expressão para incluir as chamadas de funções.


## Definição de expressão (versão 0.2)

<div class="columns">
<div class="column" width="50%">
Uma **expressão** consiste em

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

      $\rightarrow$ resultado da aplicação do operador aos operandos

</div>
</div>


## Definição de expressão (versão 0.2)

Algumas observações interessantes \pause

- Uma expressão é definida por três casos e a regra de avaliação também tem três casos. \pause

- Quando uma expressão é uma chamada de função, ela contém outras expressões. \pause Quando uma definição refere-se a si mesmo, dizemos que ela é uma definição com **autorreferência**. \pause O uso de autorreferência permite a criação de expressões de tamanhos arbitrários. \pause

- O processo de avaliação para uma expressão que é uma chamada de função requer a chamada do processo de avaliação para suas expressões. \pause Quando um processo é definido em termos de si mesmo, dizemos que ele é **recursivo**. \pause O uso de recursividade permite a avaliação de expressões de tamanhos arbitrários. \pause

- Uma autorreferência em uma definição implicada (geralmente) em uma recursão para processar os elementos que seguem a definição.


## Definição de expressão (versão 0.2)

Estamos usando os conceitos de autorreferência e recursividade para entender o funcionamento da linguagem Gleam (a estrutura das linguagens de programação são recursivas), mas iremos ver que estes conceitos são fundamentais também para criar programas no paradigma funcional.


## Avaliação de expressões

<!-- TODO: fazer uma animação -->

Exemplo de avaliação de um expressão \pause

\small

`import gleam/int.{add, multiply as mul, subtract as sub}`{.gleam} \pause

`3 * { 2 * 4 + { 3 + 5 } } + { { 10 - 7 } + 6 }`{.gleam} \pause

`add(mul(3, add(mul(2, 4), add(3, 5))), add(sub(10, 7), 6)) `{.gleam} \pause
` // mul(2, 4) -> 8`{.gleam} \pause \newline
`add(mul(3, add(8, add(3, 5))), add(sub(10, 7), 6))`{.gleam} \pause
` // add(3, 5) -> 8`{.gleam} \pause \newline
`add(mul(3, add(8, 8)), add(sub(10, 7), 6))`{.gleam} \pause
` // add(8, 8) -> 16`{.gleam} \pause \newline
`add(mul(3, 16), add(sub(10, 7), 6))`{.gleam} \pause
` // mul(3, 16) -> 48`{.gleam} \pause \newline
`add(48, add(sub(10, 7), 6))`{.gleam} \pause
` // sub(10, 7) -> 3`{.gleam} \pause \newline
`add(48, add(3, 6))`{.gleam} \pause
` // add(3, 6) -> 9`{.gleam} \pause \newline
`add(48, 9)`{.gleam} \pause
` // add(48, 9) -> 57`{.gleam} \pause \newline
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
    expressão...
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

Note que a especificação dos tipos das entradas e saída são opcionais. Se os tipos não forem especificados, eles são inferidos pelo compilador.


## Definições

Os nomes usados nas definições são associados com os objetos que eles representam e armazenados em um memória chamada de **ambiente**. \pause

Um programa em Gleam é composto por uma sequência de instruções `import`{.gleam} e de definições. \pause

Agora precisamos estender a definição de expressões para incluir nomes e alterar a regra de avaliação de expressões para considerar a chamada de funções compostas.



Modelo de substituição
======================

## Definição de expressão (versão 0.3)

<div class="columns">
<div class="column" width="35%">
Uma **expressão** consiste em

- Um literal; ou
- Uma função primitiva; ou
- Um nome; ou
- Uma chamada de função (**expressão** seguida de uma lista de **expressões** entre parênteses)

\pause
</div>
<div class="column" width="60%">
Regra para **avaliação de expressão**

- Literal $\rightarrow$ valor que o literal representa \pause
- Função primitiva $\rightarrow$ sequência de instruções de máquina associada com a função \pause
- Nome $\rightarrow$ valor associado com o nome no ambiente \pause
- Chamada de função
    - **Avalie cada expressão** da chamada da função \pause
    - Se o operador é uma função primitiva, aplique a função aos argumentos \pause
    - Senão (o operador é uma função composta) \pause, **avalie** o corpo da função **substituindo** cada ocorrência do parâmetro formal pelo argumento correspondente
</div>
</div>


## Modelo de substituição

Essa forma de calcular o resultado das chamadas das funções compostas é chamada de **modelo de substituição**.


## Modelo de substituição

\scriptsize

```gleam
fn quadrado(x) { x * x }
fn soma_quadrado(a, b) { quadrado(a) + quadrado(b) }
fn f(a) { soma_quadrados(a + 1, a * 2) }
```

```gleam
f(5)                          // Substitui f(5) pelo corpo de f com as ocorrências
                              // do parâmetro a substituídas pelo argumento 5
```

\pause

`soma_quadrados(5 + 1, 5 * 2)`{.gleam} \pause
`// Reduz 5 + 1 para o valor 6`{.gleam} \pause \newline
`soma_quadrados(6, 5 * 2)`{.gleam} \pause
`// Reduz 5 * 2 para o valor 10`{.gleam} \pause \newline
`soma_quadrados(6, 10)`{.gleam} \pause
`// Substitui soma_quadrados(6, 10) pelo corpo ...`{.gleam} \pause \newline
`quadrado(6) + quadrado(10)`{.gleam} \pause
`// Substitui quadrado(6) pelo corpo ...`{.gleam} \pause \newline
`{ 6 * 6 } + quadrado(10)`{.gleam} \pause
`// Reduz 6 * 6 para 36`{.gleam} \pause \newline
`36 + quadrado(10)`{.gleam} \pause
`// Substitui quadrado(10) pelo corpo ...`{.gleam} \pause \newline
`36 + { 10 * 10 }`{.gleam} \pause
`// Reduz 10 * 10 para 100`{.gleam} \pause \newline
`36 + 100`{.gleam} \pause
`// Reduz 36 + 100 para 136`{.gleam} \pause \newline
`136`{.gleam}


## Modelo de substituição

Ao invés de avaliar os operandos e depois fazer a substituição, existe um outro modo de avaliação que primeiro faz a substituição e apenas avalia os operandos quando (e se) eles forem necessários. \pause

<div class="columns">
<div class="column" width="50%">
\scriptsize

`f(5)`{.gleam} \pause

`soma_quadrados(5 + 1, 5 * 2)`{.gleam} \pause \newline
`quadrado(5 + 1) + quadrado(5 * 2)`{.gleam} \pause \newline
`{ 5 + 1 } * { 5 + 1 } + quadrado(5 * 2)`{.gleam} \pause \newline
`{ 5 + 1 } * { 5 + 1 } + { 5 * 2 } * { 5 * 2 }`{.gleam} \pause \newline
`6 * { 5 + 1 } + { 5 * 2 } * { 5 * 2 }`{.gleam} \pause \newline
`6 * 6 + { 5 * 2 } * { 5 * 2 }`{.gleam} \pause \newline
`36 + { 5 * 2 } * { 5 * 2 }`{.gleam} \pause \newline
`36 + 10 * { 5 * 2 }`{.gleam} \pause \newline
`36 + 10 * 10`{.gleam} \pause \newline
`36 + 100`{.gleam} \pause \newline
`136`{.gleam}

</div>
<div class="column" width="50%">
\pause

\small

A resposta gerada por essas duas formas de substituição será sempre a mesma? \pause

Para funções que terminam sim! \pause

Veremos depois os casos para funções que não terminam.
</div>
</div>


## Modelo de substituição

Este método de avaliação alternativo de primeiro substituir e depois reduzir, é chamado de **avaliação em ordem normal** (avaliação preguiçosa). \pause

O método de avaliação que primeiro avalia os argumentos e depois aplica a função é chamado de **avaliação em ordem aplicativa** (avaliação ansiosa). \pause

O Gleam usa por padrão a avaliação em ordem aplicativa.

O Haskell usa a avaliação em ordem normal.


## Exercício custo

1. O seu amigo Alan está planejando uma viagem pro final do ano com a família e está considerando diversos destinos. Uma das coisas que ele está levando em consideração é o custo da viagem, que inclui, entre outras coisas, hospedagem, combustível e o pedágio. Para o cálculo do combustível ele pediu a sua ajuda, ele disse que sabe a distância que vai percorrer, o preço do litro do combustível e o rendimento do carro (quantos quilômetros o carro anda com um litro de combustível), mas que é muito chato ficar fazendo o cálculo manualmente, então ele quer que você faça um programa para calcular o custo do combustível em uma viagem.


## Solução exercício custo

O que de fato precisa ser feito? \pause

Calcular o custo do combustível (saída) em uma viagem sabendo a distância do percurso, o preço do litro do combustível e o rendimento do carro (entradas). \pause

Como determinar o processo (forma) que a saída é computada a partir da entrada? \pause

Fazendo exemplos específicos e generalizando o processo.


## Solução exercício custo

<div class="columns">
<div class="column" width="50%">
Exemplo de entrada

- Distância: 400.0 Km
- Preço do litro: R\$ 5.0
- Rendimento: 10.0 Km/l \pause

</div>
<div class="column" width="50%">

Saída \pause

- Quantidade de litros (Distância / Rendimento): `400.0 /. 10.0`{.gleam} $\rightarrow$ `40.0`{.gleam} \pause
- Custo (Quantidade de litros $\times$ Preço do litro): `40.0 *. 5.0`{.gleam} $\rightarrow$ `200.0`{.gleam}

</div>
</div>


## Solução exercício custo

Implementação \pause

\small

```gleam
fn custo_combustivel(distancia, preco_do_litro, rendimento) {
    { distancia /. rendimento } *. preco_do_litro
}
```

\normalsize

\pause

Verificação \pause

Como verificar se a implementação faz o que é esperado? \pause

Executando os exemplos que fizemos anteriormente: \pause

\small

```gleam
> custo_combustivel(400.0, 5.0, 10.0)
200.0
```


## Exercício combustível

2. Depois que você fez o programa para o Alan, a Márcia, amiga em comum de vocês, soube que você está oferecendo serviços desse tipo e também quer a sua ajuda. O problema da Márcia é que ela sempre tem que fazer a conta manualmente para saber se deve abastecer o carro com álcool ou gasolina. A conta que ela faz é verificar se o preço do álcool é até 70% do preço da gasolina, se sim, ela abastece o carro com álcool, senão ela abastece o carro com gasolina. Você pode ajudar a Márcia também?


## Solução exercício combustível

É possível resolver este problema (produzindo como saída o tipo de combustível) usando as coisas que vimos até aqui? \pause Não! \pause

O que está faltando? \pause Algum tipo de expressão condicional. \pause

Depois voltamos à esse problema!



Condicional
===========


## Condicional

A maioria das linguagens tem `if`{.gleam} para expressar seleção, mas a linguagem Gleam não tem. Ao invés do `if`{.gleam}, ela oferece o `case`{.gleam}, que é mais genérico. \pause Vamos supor por um instante que Gleam tivesse `if`{.gleam}. \pause

<div class="columns">
<div class="column" width="50%">

A forma geral do `if`{.gleam} poderia ser:

\small

```gleam
if expressão {    // condição
    expressão...
} else {
    expressão...
}
```

\pause

</div>
<div class="column" width="50%">
Exemplos

\small

```gleam
> if 4 > 2 { 10 + 2 } else { 7 * 3 }
```

\pause

```gleam
12
```

\pause

```gleam
> if 10 == 12 { 10 + 2 } else { 7 * 3 }
```

\pause

```gleam
21
```
</div>
</div>


## Condicional

Qual a diferença desse `if`{.gleam} em relação ao das outras linguagens? \pause

Esse `if`{.gleam} é uma expressão, ele produz um valor como resultado. Na maioria das outras linguagens o `if`{.gleam} é uma sentença ([_statement_](https://en.wikipedia.org/wiki/Statement_(computer_science)) em inglês), ele não produz um resultado mas gera um efeito colateral. \pause

Vamos ver como fazer seleção usando o `case`{.gleam}.


## Condicional

A forma inicial do `case`{.gleam} é:

\small

```gleam
case expressão {        // expressão examinada
    True -> expressão   // caso True
    False -> expressão  // caso False
}
```

Onde a ordem dos casos não é importante.

\pause

<div class="columns">
<div class="column" width="50%">
\small

```gleam
> if 4 > 2 {
    10 + 2
  } else {
    7 * 3
  }
12
```

</div>
<div class="column" width="50%">
\small

```gleam
> case 4 > 2 {
    True -> 10 + 2
    False -> 7 * 3
  }
12
```

</div>
</div>


## Regra de avaliação do `case`

A regra de avaliação de expressões `case`{.gleam} é: \pause

- Avalie a expressão examinada \pause

- Se o valor da expressão examinada for `True`{.gleam}, substitua toda a expressão `case`{.gleam} pela expressão do caso `True`{.gleam} \pause

- Senão, substitua toda a expressão `case`{.gleam} pela expressão do caso `False`{.gleam}


## Exemplo abs

Vamos escrever uma função para calcular o valor absoluto de um número, isto é

$$\mathrm{abs}(x) = \begin{cases}
x & \text{se } x \ge 0 \\
-x & \text{caso contrário}
\end{cases}$$

e ver o processo de avaliação dessa função.


## Exemplo abs

<div class="columns">
<div class="column" width="30%">
\footnotesize

```gleam
fn abs(x) {
  case x >= 0 {
    True -> x
    False -> -x
  }
}
```

</div>
<div class="column" width="70%">

\footnotesize

\pause

```gleam
abs(-4)             // Substitui abs(-4) pelo corpo ...
```

\pause

```gleam
case -4 >= 0 {      // A expressão examinada é avaliada
  True -> -4
  False -> - { -4 }
}
```

\pause

```gleam
case False {        // Como a expressão examinada é False
  True -> -4        // o case é substituido pela expressão
  False -> - { -4 } // do caso False
}
```

\pause

```gleam
- { -4 }            // Reduz - { -4 } para 4
```

\pause

```gleam
4
```

</div>
</div>


## Definição de expressão (versão 1.0)

Vamos atualizar a nossa definição de expressão pra incluir o `case`{.gleam}.


## Definição de expressão (versão 1.0)

<div class="columns">
<div class="column" width="35%">
Uma **expressão** consiste em

- Um literal; ou
- Uma função primitiva; ou
- Um nome; ou
- Um case; ou
- Uma chamada de função

\pause
</div>
<div class="column" width="60%">
Regra para **avaliação de expressão**

- Literal $\rightarrow$ valor que o literal representa
- Função primitiva $\rightarrow$ sequência de instruções de máquina associada com a função
- Nome $\rightarrow$ valor associado com o nome no ambiente
- Case $\rightarrow$ avalie usando a regra de avaliação do case
- Chamada de função $\rightarrow$ avalie usando a regra de avaliação de chamadas de funções
</div>
</div>


## Exercício sinal

Defina a função `sinal` que determina o sinal de um número inteiro. \pause

<div class="columns">
<div class="column" width="50%">

\small

```gleam
> sinal(4)
1
> sinal(0)
0
> sinal(-7)
-1
```

\pause


</div>
<div class="column" width="50%">

\small

```gleam
fn sinal(x) {
  case x > 0 {
    True -> 1
    False ->
      case x == 0 {
        True -> 0
        False -> -1
      }
  }
}
```

</div>
</div>


## Exercício and

<div class="columns">
<div class="column" width="38%">

Defina a função `and`{.gleam} que recebe os argumentos booleanos `x`{.gleam} e `y`{.gleam} e produz como resposta o e lógico entre eles, isto é \pause

\small

```gleam
> and(False, False)
False
> and(False, True)
False
> and(True, False)
False
> and(True, True)
True
```

\pause

</div>
<div class="column" width="60%">

\small

Observe o exemplos e responda: \pause se verificarmos o valor de `x`, e ele for `False`{.gleam}, qual é o resultado da função? \pause `False`{.gleam}. \pause

E se `x` for `True`{.gleam}? \pause Verificamos o valor de `y`, se for `True`{.gleam}, o resultado da função é `True`{.gleam}, senão, o resultado da função é `False`{.gleam}. \pause

```gleam
fn and(x, y) {
  case x {
    False -> False
    True ->
      case y {
        True -> True
        False -> False
      }
  }
}
```
</div>
</div>


## Exercício and

<div class="columns">
<div class="column" width="50%">

\small

```gleam
fn and(x, y) {
  case x {
    False -> False
    True ->
      case y {
        True -> True
        False -> False
      }
  }
}
```

\pause

\normalsize

Podemos simplificar a função? \pause Sim! \pause

</div>
<div class="column" width="50%">

\small

```gleam
fn and(x, y) {
  case x {
    False -> False
    True -> y
  }
}
```

</div>
</div>


## Exercício or

<div class="columns">
<div class="column" width="45%">

Defina a função `or`{.gleam} que recebe os argumentos booleanos `x`{.gleam} e `y`{.gleam} e produz como resposta o ou lógico entre eles, isto é \pause

\small

```gleam
> or(False, False)
False
> or(False, True)
True
> or(True, False)
True
> or(True, True)
True
```

</div>
<div class="column" width="50%">

\pause

\small

```gleam
fn or(x, y) {
  case x {
    True -> True
    False -> y
  }
}
```

</div>
</div>


## Limitações das funções and e or

Existe alguma implicação em definirmos `and` e `or` como funções? \pause

Sim, elas serão avaliadas como funções, ou seja, todos os argumentos são avaliados antes das funções serem avaliadas e isso impede que algumas otimizações sejam feitas. \pause

Especificamente, na implementação do `and`, se a primeira expressão for `False`{.gleam}, não é necessário avaliar a segunda expressão. De forma semelhante, no `or`, se a primeira expressão for `True`{.gleam}, não é necessário avaliar a segunda expressão. \pause

Essa otimização, chamada de **avaliação em curto-circuito**, é usada em outras linguagens e permitem escrever condições dependentes, como por exemplo `x != 0 and 10 / x == 2`{.python}, o que não é possível se todos os argumentos para o `and` são avaliados. \pause

Avaliação em curto-circuito é um tipo de avaliação preguiçosa.


Operadores lógicos
==================

## Operadores lógicos

A linguagem Gleam oferece os operadores lógicos `&&`{.gleam} (and), `||`{.gleam} (or) e `!`{.gleam} (not).\pause

Os operadores `&&`{.gleam} e `||`{.glema} são binários e `!`{.gleam} é unário.\pause

O operador `&&`{.gleam} produz `True`{.gleam} quando os dois operandos são `True`{.gleam}. \pause

O operador `||`{.gleam} produz `True`{.gleam} quando pelo menos um dos dois operandos é `True`{.gleam}. \pause

O operador `!`{.gleam} produz `True`{.gleam} se o operando é `False`{.gleam} e `False`{.gleam} se o operando é `True`{.gleam}.


## Exemplos dos operadores lógicos

Alguns exemplos

<div class="columns">
<div class="column" width="50%">
\small

```gleam
> 3 > 4 || 2 == 1 + 1
True
> 3 > 4 && 2 == 1 + 1
False
```

</div>
<div class="column" width="50%">
\small

```gleam
> !True
False
> bool.negate(2 == 4)
True
```

</div>
</div>

\pause

\ 

<div class="columns">
<div class="column" width="50%">

\small

Diferente do Python, a negação tem prioridade menor que os operadores relacionais. \pause

```gleam
> ! 3 > 4
erro
> !{ 3 > 4 }
True
```

\pause

</div>
<div class="column" width="50%">

\small

O operador `&&`{.gleam} tem maior prioridade do que `||`{.gleam}. \pause

```gleam
>>> True || False && False
True
```

\pause

```gleam
>>> { True || False } && False
False
```

</div>
</div>


## Avaliação em curto-circuito

Assim como em outras linguagens, os operadores `&&`{.gleam} e `||`{.gleam} são avaliados em curto-circuito. \pause

Ou seja, esses operadores tem regras de avaliação específicas e não são avaliados como funções.


## Regra de avaliação da expressão `&&`

A regra de avaliação da expressão `&&`{.gleam} é: \pause

- Avalie a expressão a esquerda de `&&`{.gleam}, se o valor for `False`{.gleam}, substitua toda a expressão `&&`{.gleam} por `False`{.gleam}; \pause

- Senão, substitua toda a expressão `&&`{.gleam} pela expressão à direita de `&&`{.gleam}.


## Regra de avaliação da expressão ||

A regra de avaliação da expressão `||`{.gleam} é: \pause

- Avalie a expressão a esquerda de `||`{.gleam}, se o valor for `True`{.gleam}, substitua toda a expressão `||`{.gleam} por `True`{.gleam}; \pause

- Senão, substitua toda a expressão `||`{.gleam} pela expressão à direita de `||`{.gleam}.


## Operadores lógicos

Os exemplos a seguir usam o efeito colateral de `io.debug`{gleam} para demostrar a avaliação em curto-circuito.

<div class="columns">
<div class="column" width="50%">
\footnotesize

```gleam
> 3 > 5 && { io.debug("aqui") True }
```

\pause

```gleam
False
```

\pause

```gleam
> 5 > 3 && { io.debug("aqui") True }
```

\pause

```gleam
"aqui"
True
```

\pause

</div>
<div class="column" width="50%">
\footnotesize

```gleam
> 3 > 5 || { io.debug("aqui") True }
```

\pause

```gleam
"aqui"
False
```

\pause

```gleam
> 5 > 3 || { io.debug("aqui") True }
```

\pause

```gleam
True
```
</div>
</div>



Igualdade
=========


## Igualdade

A linguagem Gleam oferece apenas um operador de igualdade, o `==`{.gleam}, que pode ser usado para quaisquer dois valores do mesmo tipo. \pause

Em Gleam, dois valores são iguais se eles são estruturalmente iguais. \pause

O operador de diferente (negação da igualdade) é `!=`{.gleam}.


## Igualdade

<div class="columns">
<div class="column" width="50%">
\small

```gleam
> 10 == 9 + 1
```

\pause

```gleam
True
```

\pause

```gleam
> 3.0 + 1.0 == 4.0
```

\pause

```gleam
True
```

\pause

```gleam
> 10 == 10.0
```

\pause

```
error: Type mismatch
```

\pause

</div>
<div class="column" width="50%">
\small

```gleam
> ["a", "c", "b"] == ["a", "c", "b"]
```

\pause

```gleam
True
```

\pause

```gleam
> [[], [1, 2]] == [[], [1, 2]]
```

\pause

```gleam
True
```

\pause

```gleam
> [[], [1, 2]] != [[], [1, 2]]
```

\pause

```gleam
False
```

</div>
</div>


## Revisão

Vimos o que são expressões e como elas são avaliadas. \pause

- A definição de expressão tem autorreferência, isto é, uma expressão pode conter outras expressões. \pause

- A regra de avaliação de expressão é recursiva, isto é, a regra é descrita em termos dela mesmo.


## Revisão

Aprendemos os tipos e operações primitivas do Gleam e também como fazer definições de constantes e funções. \pause

- `Int`{.gleam}, `Float`{.gleam}, `String`{.gleam} e `Bool`{.gleam} \pause

- `+`{.gleam} (`int.add`{.gleam}), `*.`{.gleam} (`float.multiply`{.gleam}), `==`{.gleam} e muitas outras \pause

- `&&`{.gleam}, `||`{.gleam} operadores avaliados com uma regra especial (avaliação preguiçosa) \pause

- `case`{.gleam} \pause

- `const`{.gleam} \pause

- `fn`{.gleam}


Referências
===========

## Referências

Básicas

- Seção [1.1 - The Elements of Programming](https://web.mit.edu/6.001/6.037/sicp.pdf#section.1.1) do livro [SICP](https://web.mit.edu/6.001/6.037/sicp.pdf)

- [Tour da linguagem Gleam](https://tour.gleam.run/)

- [Biblioteca padrão do Gleam](https://hexdocs.pm/gleam_stdlib/)
