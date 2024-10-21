---
# vim: set spell spelllang=pt_br sw=4:
# TODO: usar um exemplo mais interessante do que Ponto
# TODO: colocar explicitamente a definição de estrutura, enumeração e união
# TODO: falar o que é uma instância
# TODO: introduzir com mais detalhes o conceito de união
# TODO: melhorar o exemplo de união
# TODO: falar do "expression problem"?
# TODO: remover (discutido em sala) adicionando um exemplo inicial
# TODO: adicionar mais referências sobre projeto de tipos de dados
title: Tipos de dados
---

Introdução
==========


## Introdução

Qual é a segunda etapa no processo de projeto de funções? \pause Definição de tipos de dados. \pause

Qual o propósito dessa etapa? \pause Identificar as informações e definir como elas serão representadas. \pause

Essa etapa pode ter parecido, até então, muito simples ou talvez até desnecessária, isto porque as informações que precisávamos representar eram "simples". \pause

No entanto, essa etapa é muito importante no projeto de programas, de fato, vamos ver que para muitos casos, os tipos de dados vão guiar o restante das etapas do projeto. \pause

Vamos começar com a definição do que é um tipo de dado.


## Definição

Um **tipo de dado** é um conjunto de valores que uma variável pode assumir. \pause

Exemplos \pause

- Booleano $= \{ verdadeiro, falso \}$ \pause
- Natural = $\{ 0, 1, 2, \dots \}$ \pause
- Inteiro = $\{\dots, -2, -1, 0, 1, 2, \dots \}$ \pause
- String = $\{$ '', 'a', 'b', $\dots \}$ \pause
- String que começa com a = $\{$ 'a', 'aa', 'ab', $\dots \}$


## Adequação de tipo de dado

Durante a etapa de definição de tipos de dados identificamos as informações e definimos como elas são representadas no programa. \pause

Como determinar se um tipo de dado **é adequado** para representar uma informação?


## Adequação de tipo de dado

Um inteiro é adequado para representar a quantidade de pessoas em um planeta? \pause E um natural de 32 bits? \pause E um natural? \pause

- Um inteiro não é adequado pois ele pode ser negativo, mas a quantidade de pessoas em um planeta não pode, ou seja, o tipo permite representar valores inválidos; \pause

- Uma natural de 32 bits não é adequado pois o valor máximo possível é 4.294.967.295, mas o planeta terra tem mais pessoas que isso, ou seja, o tipo não permite representar todos os valores válidos; \pause

- Um natural é adequado. Cada valor do conjunto dos naturais representa um valor válido de informação, e cada possível valor de informação pode ser representado por um número natural.


## Diretrizes para o projeto de tipos de dados

Diretrizes para o projeto de tipos de dados: \pause

- Faça os valores válidos representáveis. \pause

- Faça os valores inválidos irrepresentáveis. \pause

Vamos aplicar esses princípios a uma série de exemplos.


## Exemplo combustível

No exemplo da escolha do combustível, nós definimos ose seguintes tipos:

\small

```gleam
/// O preço do litro do combustível,
/// deve ser um número positivo.
type Preco = Float

/// O tipo do combustível,
/// deve "Alcool" ou "Gasolina".
type Combustivel = String
```

\pause

\normalsize

Esses tipos estão de acordo com as diretrizes para o projeto de tipos de dados? \pause

Não! \pause

Vamos resolver essa questão começando com `Combustivel`{.gleam}.



Enumerações
===========

## Enumerações

Em um **tipo enumerado** todos os valores do tipos são enumerados explicitamente. \pause

A forma geral para definir tipos enumerados é:

\small

```gleam
[pub] type NomeDoTipo {
  Valor1
  Valor2
  ...
  Valorn
}
```

\pause

\normalsize

Cada tipo enumerado pode ter 0 ou mais valores. \pause O nome e os valores do tipo devem começar com letra maiúscula.

\pause

Vamos definir um tipo enumerado para representar o tipo combustível.


## Combustível

<div class="columns">
<div class="column" width="48%">

\small

```gleam
pub type Combustivel {
  Alcool
  Gasolina
}
```

\pause

\normalsize

Podemos utilizar os operadores `==` e `!=` e a função `string.inspect`{.gleam} com os valores de tipos enumerados. \pause

\small

```gleam
> Alcool == Gasolina
False
> Alcool != Gasolina
True
> string.inspect(Gasolina)
"Gasolina"
```

\pause


</div>
<div class="column" width="48%">
Assim como para valores do tipo `Bool`{.gleam}, podemos utilizar a expressão `case`{.gleam} para processar valores de tipos enumerados. \pause De fato, o tipo `Bool`{.gleam} é um tipo enumerado com os valores `True`{.gleam} e `False`{.gleam} pré-definido na linguagem. \pause

\small

```gleam
pub fn msg_combustivel(c: Combustivel) {
  case c {
    Alcool -> "Use álcool."
    Gasolina -> "Use gasolina."
  }
}
```

</div>
</div>


## Combustível

A análise dos casos precisa ser exaustiva

\scriptsize

```gleam
pub fn msg_combustivel(c: Combustivel) {
  case c {
    Alcool -> "Use álcool."
  }
}
```

\pause

```
  ┌─ src/arquivo.gleam:2:3
  │
2 │ +   case c {
3 │ │     Alcool -> "a"
4 │ │   }
  │ +───^

This case expression does not have a pattern for all possible values. If it is run on one of
the values without a pattern then it will crash.
The missing patterns are:
    Gasolina
```


## Exemplo - tíquete do RU

O RU da UEM cobra um valor por tíquete que depende da relação do usuário com a universidade. Para alunos e servidores que recebem até 3 salários mínimos o tíquete custa R$ 5,00, para servidores que recebem acima de 3 salários mínimos e docentes R$ 10,00, para pessoas da comunidade externa, R$ 19,00. Como parte de um sistema de cobrança você deve projetar uma função que determine quanto deve ser cobrado de um usuário por um quantidade de tíquetes.


## Exemplo - tíquete do RU

Análise \pause

- Determinar quanto deve ser cobrado de um usuário por uma quantidade de tíquetes \pause

- O usuário pode ser aluno ou servidor (até 3 sal) - R$ 5, servidor (acima de 3 sal) ou docente - R$ 10, ou externo R$ 19. \pause

Definição de tipos de dados \pause

- As informações são a quantidade, o tipo de usuário e o valor que deve ser cobrado.


## Exemplo - tíquete do RU

Como representar um tipo de usuário? \pause Criando um tipo enumerado com os valores possíveis para o tipo. \pause

\small

```gleam
/// Representa o tipo de um usuário do RU da UEM.
pub type Usuario {
    Aluno
    // Servidor que recebe até 3 salários mínimos.
    ServidorAte3
    // Servidor que recebe mais do que 3 salários mínimos.
    ServidorMais3
    Docente
    Externo
}
```


## Exemplo - tíquete do RU

Especificação

\small

```gleam
/// Determina o custo de *quant* tíquetes para um usuário do tipo *usuario*.
/// O custo de um tíquete é
/// - Aluno           5,0
/// - ServidorAte3    5,0
/// - ServidorMais3  10,0
/// - Docente        10,0
/// - Externo        19,0
/// Se *quant* for negativo, devolve 0.0.
pub fn custo_tiquetes(usuario: Usuario, quant: Int) -> Float
```


## Exemplo - tíquete do RU

Quantos exemplos são necessários para funções que processam valores de tipos enumerados? \pause Pelo menos um para cada valor da enumeração. \pause

\small

```gleam
pub fn custo_tiquetes_examples() {
  check.eq(custo_tiquetes(Aluno, 3), 15.0)
  check.eq(custo_tiquetes(ServidorAte3, 2), 10.0)
  check.eq(custo_tiquetes(ServidorMais3, 2), 20.0)
  check.eq(custo_tiquetes(Docente, 3), 30.0)
  check.eq(custo_tiquetes(Externo, 4), 76.0)
}
```

\pause

\normalsize

Como iniciamos a implementação de uma função que processa um valor de tipo enumerado? \pause Criando um caso para cada valor da enumeração.


## Exemplo - tíquete do RU

Implementação

\small

```gleam
pub fn custo_tiquetes(usuario: Usuario, quant: Int) -> Float {
  case usuario {
    Aluno ->
    ServidorAte3 ->
    ServidorMais3 ->
    Docente ->
    Externo ->
  }
}
```

\pause

Agora completamos o corpo considerando cada forma de resposta dos exemplos.


## Exemplo - tíquete do RU

Implementação

\small

```gleam
pub fn custo_tiquetes(usuario: Usuario, quant: Int) -> Float {
  case usuario {
    Aluno -> 5.0 *. int.to_float(quant)
    ServidorAte3 -> 5.0 *. int.to_float(quant)
    ServidorMais3 -> 10.0 *. int.to_float(quant)
    Docente -> 10.0 *. int.to_float(quant)
    Externo -> 19.0 *. int.to_float(quant)
  }
}
```

\pause

A implementação está correta? \pause Não, precisamos tratar `quant` negativo. \pause Fica como atividade.


Estruturas
==========


## Introdução

Os tipos de dados que vimos até agora são atômicos, isto é, não podem ser decompostos. \pause

Agora veremos como representar dados onde dois ou mais valores devem ficar juntos: \pause

- Registro de um aluno;

- Placar de um jogo de futebol;

- Informações de um produto. \pause

Chamamos estes tipos de dados de **dados compostos** ou **estruturas**.


## Estruturas

A forma geral para definir um **dado composto** é:

```gleam
[pub] type Nome {
  Nome([campo1:] Tipo1, [campo2:] Tipo2, ...)
}
```

\pause

Vamos definir uma estrutura para representar um ponto em um plano cartesiano.


## Estruturas

<div class="columns">
<div class="column" width="48%">
\small

Definição

```gleam
type Ponto {
  Ponto(x: Int, y: Int)
}
```

\pause

Construção

```gleam
const p1: Ponto = Ponto(x: 3, y: 4)
const p2 = Ponto(8, 2)
```
</div>
<div class="column" width="48%">

\small

\pause

Decomposição

```scheme
> p1.x
3
> p1.y
4
```

\pause

```gleam
> let Ponto(x, y) = p2
Ponto(x: 8, y: 2)
> x
8
> y
2
```
</div>
</div>



## Sintaxe de `struct`{.scheme}

Uma aproximação da sintaxe do `struct`{.scheme} é

```scheme
(struct <id-estrutura> (<id-campo-1> ...))
```


## Funções definidas na criação de uma estrutura

<div class="columns">
<div class="column" width="48%">
Funções definidas com `struct`{.scheme}

\small

```scheme
;; Construtor
id-estrutura

;; Predicado que verifica se um objeto
;; é do tipo da estrutura
id-estrutura?

;; Seletores
id-estrutura-id-campo
```
</div>
<div class="column" width="48%">
\pause

Por exemplo, a estrutura

\small

```scheme
(struct ponto (x y))
```

Define as funções

```scheme
;; Construtor
ponto

;; Predicado
ponto?

;; Seletores
ponto-x
ponto-y
```

</div>
</div>


## Funções definidas na criação de uma estrutura

Note que o construtor, o predicado de tipo e os seletores criados por `struct`{.scheme} são funções comuns, e portando são utilizados como todas as outras funções.

\small

```
> (struct ponto (x y))
> ponto
#<procedure:ponto>
> ponto?
#<procedure:ponto?>
> ponto-x
#<procedure:ponto-x>
> ponto-y
#<procedure:ponto-y>
```


## Estruturas transparentes

Por padrão, ao exibir uma instância de uma estrutura o Racket não exibe o valor dos campos (para preservar o encapsulamento).

\pause

```scheme
(struct ponto (x y))
```

\pause

```scheme
> (ponto (+ 1 2) 4)
#<ponto>
```


## Estruturas transparentes

Podemos usar a palavra chave `#:transparent`{.scheme} para tornar a estrutura "transparente" (podemos ver os valores dos campos).

\pause

```scheme
(struct ponto (x y) #:transparent)
```

\pause

```scheme
; mesmo formato de criação e de exibição
> (ponto (+ 1 2) 4)
(ponto 3 4)
```


## Estruturas transparentes e a função `equal?`

Além de mudar a forma que o ponto é exibido, a palavra chave `#:transparent`{.scheme} também altera o funcionamento da função `equal?`{.scheme}.


## Estruturas transparentes e a função `equal?`

```scheme
;; Por padrão, dois pontos são iguais se eles são
;; o mesmo ponto.
(struct ponto (x y))

(define p1 (ponto 3 4))
(define p2 (ponto 3 4))

> (equal? p1 p2)
#f
> (equal? p1 p1)
#t
```


## Estruturas transparentes e a função `equal?`

```scheme
;; Com :#transparent, dois pontos são iguais se os seus
;; campos são iguais.
(struct ponto (x y) #:transparent)

(define p1 (ponto 3 4))
(define p2 (ponto 3 4))

> (equal? p1 p2)
#t
> (equal? p1 p1)
#t
```


## Definindo estruturas

Junto com a definição de uma estrutura, também faremos a descrição do seu propósito e do seus campos.


## Definindo estruturas

```scheme
(struct ponto (x y))
;; Ponto representa um ponto no plano cartesiano
;;   x : Número - a coordenada x
;;   y : Número - a coordenada y
```


## Alterando dados estruturados

Podemos utilizar os seletores para consultar o valor de um campo, mas como alterar o valor de um campo? \pause Não tem como! \pause Lembrem-se, estamos estudando o paradigma funcional, onde não existe mudança de estado! \pause

Ao invés de modificar o campo de uma instância da estrutura, criamos uma cópia da instância com o campo alterado.

\pause

Vamos criar um ponto `p2` que é como `p1`, mas com o valor 5 para o campo `y`. \pause

```scheme
> (define p1 (ponto 3 4))
> (define p2 (ponto (ponto-x p1) 5))
> p2
(ponto 3 5)
```


## Alterando dados estruturados

Quais são as limitações desse método? \pause

- Se a estrutura tem muitos campos e desejamos alterar apenas um campo, temos que especificar a cópia de todos os outros \pause

- Se a estrutura é alterada pela adição ou remoção de campos, então, todas as operações de "cópia" da estrutura no código devem ser alteradas


## Alterando dados estruturados

Racket oferece a forma especial `struct-copy` ([referência](http://docs.racket-lang.org/reference/struct-copy.html)), que facilita este tipo de operação.


## Alterando dados estruturados

\small

```scheme
> (define p1 (ponto 3 4))
> (define p2 (struct-copy ponto p1 [y 5]))
> p2
(ponto 3 5)
```

\pause

```scheme
> (define p3 (struct-copy ponto p2 [x 4]))
> p3
(ponto 4 5)
```

\pause

```scheme
> ; podemos especificar o novo valor de mais de um campo
> ; não faz sentido para ponto... mas vale o exemplo!
> (define p4 (struct-copy ponto p2 [y 9] [x 6]))
> p4
(ponto 6 9)
```


## Exemplo - outras linguagens

A ideia de estruturas imutáveis que são "atualizadas" através de cópias está presentes em diversas linguagens. \pause A seguir temos um exemplo em Python e outro em Rust.

\pause

<div class="columns">
<div class="column" width="48%">
\scriptsize

```python
from dataclasses import dataclass, replace

@dataclass(frozen=True)
class Ponto:
    x: int
    y: int

>>> p = Ponto(10, 20)

>>> # Atribuição inválida, p é imutável
>>> p.x = 8

>>> # Cria uma cópia de p alterando x para 8
>>> p1 = replace(p, x=8)
>>> p1
Ponto(x=8, y=20)
```

\pause

</div>
<div class="column" width="48%">

\scriptsize

```rust
struct Ponto {
    x: i32,
    y: i32,
}

fn main() {
    let p = Ponto { x: 10, y: 20 };

    // Atribuição inválida, p é imutável
    p.x = 8;

    // Cria uma cópia de p alterando x para 8
    let p1 = Ponto {x: 8, ..p};
    assert_eq!(p1.x, 8);
    assert_eq!(p1.y, 20);
}
```

</div>
</div>


## Exemplo - distância

Defina uma função que calcule a distância de um ponto a origem.


## Exemplo - distância

\small

```scheme
;; Ponto -> Número
;; Calcula a distância do ponto p a origem.
;; A distância de um ponto (x, y) até a origem é calculada
;; pela raiz quadrada de x^2 + y^2.
(examples
 (check-equal? (distancia-origem (ponto 0 7)) 7)
 (check-equal? (distancia-origem (ponto 1 0)) 1)
 ;; (sqrt (+ (sqr 3) (sqr 4))
 (check-equal? (distancia-origem (ponto 3 4)) 5))
(define (distancia-origem p) 0)
```

\pause

```scheme
(define (distancia-origem p)
  (sqrt (+ (sqr (ponto-x p))
           (sqr (ponto-y p)))))
```




## Exemplo - Campo minado

Campo minado é um famoso jogo de computador. O jogo consiste de um campo retangular de quadrados que podem ou não conter minas escondidas. Os quadrados podem ser abertos clicando sobre eles. O objetivo do jogo é abrir todos os quadrados que não têm minas. Se o jogador abrir um quadrado com uma mina, o jogo termina e o jogador perde.

\pause

Como guia para explorar o campo, cada quadrado aberto exibe o número de minas nos quadrados ao seu redor (no máximo 8). Quando um quadrado sem minas ao redor é aberto, todos os quadrados ao seu redor também são abertos. O usuário pode colocar uma bandeira sobre um quadrado fechado para sinalizar uma possível mina e impedir que ele seja aberto. Uma bandeira também pode ser removida de um quadrado.


## Exemplo - Campo minado

![](imagens/campo-minado.png){width=8cm}


## Exemplo - Campo minado

Projete um tipo de dado para representar um quadrado em um jogo de campo minado. Não é necessário armazenar o número de bombas ao redor do quadrado pois esse valor pode ser calculado dinamicamente.


## Exemplo - Campo minado

Em uma primeira tentativa poderíamos pensar: o quadrado pode ter uma mina ou não, pode estar fechado ou aberto e pode ter uma bandeira ou não. \pause Como são três item relacionados, então definiríamos uma estrutura. Além disso, cada item tem dois estados possíveis, então poderíamos usar booleano para representar cada estado. \pause

\small

```scheme
(struct quadrado (mina? aberto? bandeira?) #:transparent)
;; Representa um quadrado no jogo campo minado.
;;  mina?    : Bool - #t se tem uma mina no quadrado, #f caso contrário
;;  aberto?  : Bool - #t se o quadrado está aberto, #f caso contrário
;;  bandeira?: Bool - #t se tem uma bandeira no quadrado, #f caso contrário
```


## Exemplo - Campo minado

Nós vimos duas diretrizes para o projeto de tipo de dado

- Faça os valores válidos representáveis.
- Faça os valores inválidos irrepresentáveis. \pause

A definição de `quadrado` está de acordo com essas diretrizes? \pause Vamos verificar! \pause

Quantas possíveis instâncias distintas existem de `quadrado`? \pause São três campos, cada um pode assumir dois valores, portanto, $2 \times 2 \times 2 = 8$. \pause

Vamos listar essas instâncias e analisar se todas são válidas.


## Exemplo - Campo minado

<div class="columns">
<div class="column" width="48%">

\small

| `mina?`       | `aberto?`      | `bandeira?`    | Válido?       |
|:-------------:|:--------------:|:--------------:|:-------------:|
| `#f`{.scheme} | `#f`{.scheme}  | `#f`{.scheme}  | \pause Sim \pause |
| `#f`{.scheme} | `#f`{.scheme}  | `#t`{.scheme}  | \pause Sim \pause |
| `#f`{.scheme} | `#t`{.scheme}  | `#f`{.scheme}  | \pause Sim \pause |
| `#f`{.scheme} | `#t`{.scheme}  | `#t`{.scheme}  | \pause Não \pause |
| `#t`{.scheme} | `#f`{.scheme}  | `#f`{.scheme}  | \pause Sim \pause |
| `#t`{.scheme} | `#f`{.scheme}  | `#t`{.scheme}  | \pause Sim \pause |
| `#t`{.scheme} | `#t`{.scheme}  | `#f`{.scheme}  | \pause Sim \pause |
| `#t`{.scheme} | `#t`{.scheme}  | `#t`{.scheme}  | \pause Não        |

\pause

Temos dois estados inválidos!

</div>
<div class="column" width="48%">
\pause
Como evitar estes estados inválidos? \pause Primeiro temos que entender o problema. \pause

A questão é que apenas 3 das 4 possíveis combinações dos valores dos campos `aberto?` e `bandeira?` são válidos: aberto, fechado ou fechado com bandeira. \pause

Para resolver a situação podemos "juntar" os campo `aberto?` e `bandeira?` em um campo `estado` que pode assumir um desses três valores.
</div>
</div>


## Exemplo - Campo minado

\small

```scheme
;; Estado é um dos valores:
;; - "aberto"
;; - "fechado"
;; - "fechado-com-bandeira"

(struct quadrado (mina? estado) #:transparent)
;; Representa um quadrado no jogo campo minado.
;;  mina? : Bool - #t se tem uma mina no quadrado, #f caso contrário
;;  estado: Estado - o estado do quadrado
```

\pause

Quantas possíveis instâncias distintas existem de `quadrado`? \pause O campo `mina?` pode assumir dois valores e o campo `estado` 3, portanto, $2 \times 3 = 6$, que são os seis estados válidos que identificamos anteriormente.


## Exemplo - Ação campo minado

Agora que temos uma representação adequada para um quadrado, podemos avançar e projetar uma função que determina como um quadrado ficará após a ação de um usuário. O usuário pode fazer uma ação para abrir um quadrado, adicionar uma bandeira ou remover uma bandeira.


## Exemplo - Ação campo minado

Análise \pause

- Determinar o novo estado de um quadrado a partir da ação do usuário \pause

Definição de tipos de dados \pause

\small

```scheme
;; Acao é um dos valores:
;; - "abrir"
;; - "adicionar-bandeira"
;; - "remover-bandeira"
```


## Exemplo - Ação campo minado

\small

Especificação \pause

Quais são as entradas para a função? \pause Um quadrado e uma ação. \pause

Qual é a saída da função? \pause Um quadrado. \pause

Qual é o campo do quadrado de entrada que pode mudar? \pause Apenas o estado. \pause

Do que depende a mudança do estado? \pause Do estado atual e da ação. \pause

Se o comportamento de uma função depende apenas de um valor enumerado, quantos exemplos precisamos colocar na especificação? \pause Um para cada valor da enumeração. \pause

A função que estamos projetando depende de apenas um valor enumerado? \pause Não. \pause Depende de dois, o valor do estado e o valor da ação. \pause

Quantos exemplos precisamos nesse caso? \pause Pelo menos $3 \times 3 = 9$ exemplos. \pause Vamos fazer uma tabela para não esquecer de nenhum caso!


## Exemplo - Ação campo minado

\small

| estado/ação                |     abrir      |   adicionar          |   remover     |
|:--------------------------:|:--------------:|:--------------------:|:-------------:|
| aberto \pause              |      -         |       -              |      - \pause |
| fechado \pause             |    aberto      | fechado-com-bandeira |      - \pause |
| fechado-com-bandeira \pause|      -         |       -              |   fechado     |

\pause


```scheme
(examples
  ; q
  (check-equal? (atualiza-quadrado (quadrado #f "aberto") "abrir")
                (quadrado #f "aberto"))
  ; (struct-copy quadrado q [estado "aberto"])
  (check-equal? (atualiza-quadrado (quadrado #f "fechado") "abrir")
                (quadrado #f "aberto"))
  ...)
```


## Exemplo - Ação campo minado

Implementação \pause

Se o comportamento de uma função depende apenas de um valor enumerado, qual é a estrutura inicial do corpo da função? \pause Uma seleção com uma condição para cada valor enumerado. \pause

A função que estamos projetando depende de dois valores enumerados, qual deve ser a estrutura inicial do corpo da função? \pause Uma seleção de dois níveis, cada nível para um valor enumerado; \pause ou; uma seleção com uma condição para cada par dos valores enumerados.


## Exemplo - Ação campo minado

<div class="columns">
<div class="column" width="48%">
\scriptsize

\vspace{-0.15cm}

```scheme
(define (atualiza-quadrado q acao)
  (define estado (quadrado-estado q))
  (cond
    [(equal? estado "aberto")
     (cond
       [(equal? acao "abrir") ...]
       [(equal? acao "adicionar-bomba") ...]
       [(equal? acao "remover-bomba") ...])]
    [(equal? estado "fechado")
     (cond
       [(equal? acao "abrir") ...]
       [(equal? acao "adicionar-bomba") ...]
       [(equal? acao "remover-bomba") ...])]
    [(equal? estado "fechado-com-bandeira")
     (cond
       [(equal? acao "abrir") ...]
       [(equal? acao "adicionar-bomba") ...]
       [(equal? acao "remover-bomba") ...])]))

```

</div>
<div class="column" width="48%">
\scriptsize

\vspace{-0.15cm}

```scheme
(define (atualiza-quadrado q acao)
  (define estado (quadrado-estado q))
  (cond [(and (equal? estado "aberto")
              (equal? acao "abrir")) ...]
        [(and (equal? estado "aberto")
              (equal? acao "adicionar-bomba")) ...]
        [(and (equal? estado "aberto")
              (equal? acao "remover-bomba")) ...]
        [(and (equal? estado "fechado")
              (equal? acao "abrir")) ...]
        [(and (equal? estado "fechado")
              (equal? acao "adicionar-bomba")) ...]
        [(and (equal? estado "fechado")
              (equal? acao "remover-bomba")) ...]
        [(and (equal? estado "com-bomba")
              (equal? acao "abrir")) ...]
        [(and (equal? estado "com-bomba")
              (equal? acao "adicionar-bomba")) ...]
        [(and (equal? estado "com-bomba")
              (equal? acao "remover-bomba")) ...]))
```
</div>
</div>


## Exemplo - Ação campo minado

\small

| estado/ação          |     abrir      |   adicionar          |   remover     |
|:--------------------:|:--------------:|:--------------------:|:-------------:|
| aberto               |      -         |       -              |      -        |
| fechado              |    aberto      | fechado-com-bandeira |      -        |
| fechado-com-bandeira |      -         |       -              |   fechado     |

\pause

\normalsize

Se olharmos a tabela de exemplos, vamos notar que em apenas 3 casos precisamos atualizar o quadrado, então, não é necessário colocar explicitamente no código os 9 casos, podemos simplificar o código antes mesmo de escrevê-lo!


## Exemplo - Ação campo minado

\small

```scheme
(define (atualiza-quadrado q acao)
  (define estado (quadrado-estado q))
  (cond
    [(and (equal? estado "fechado")
          (equal? acao "abrir"))
     (struct-copy quadrado q [estado "aberto"])]
    [(and (equal? estado "fechado")
          (equal? acao "adicionar-bandeira"))
     (struct-copy quadrado q [estado "fechado-com-bandeira"])]
    [(and (equal? estado "fechado-com-bandeira")
          (equal? acao "remover-bandeira"))
     (struct-copy quadrado q [estado "fechado"])]
    [else q]))
```


Uniões
======


## Problema - Estado tarefa

Projete uma função que exiba uma mensagem sobre o estado de uma tarefa. Uma tarefa pode estar em execução, ter sido concluída em uma duração específica e com um mensagem de sucesso, ou ter falhado com um código e uma mensagem de erro.

\pause

Como representar o estado de uma tarefa? \pause

Vamos tentar uma estrutura.


## Problema - Estado tarefa

\small

```scheme
(struct estado-tarefa (executando duracao msg_sucesso codigo_err msg_err))
;; Representa o estado de uma tarefa.
;; executando: Bool - #t se a tarefa está em execução, #f caso contrário
;; duracao: Número - tempo que durou a execução da tarefa
;; msg_sucesso: String - mensagem caso a tarefa tenha sido executada com sucesso
;; codigo_err: Número - código de erro se a execução da tarefa falhou
;; msg_err: String - mensagem de erro se a execução da tarefa falhou
```

\pause

Qual é o problema dessa representação? \pause

Possíveis estados inválidos. \pause O que significa

`(estado-tarefa #t 10 "Ótimo desempenho" 123 "Falha na conexão")`{.scheme}? \pause

Como evitar esse problema?


## Problema - Estado tarefa

Analisando a descrição do problema conseguimos separar o estado da tarefa em três casos: \pause

- Em execução \pause
- Sucesso, com uma duração e uma mensagem \pause
- Erro, com um código e uma mensagem \pause

Esses casos são excludentes, ou seja, se a tarefa se enquadra em um deles, não devemos armazenar informações sobre os outros (caso contrário, seria possível criar um estado inconsistente). \pause

E como expressar esse tipo de dado? \pause Usando união de tipos.


## Uniões e Estruturas

Definimos anteriormente um tipo de dado como um conjunto de possíveis valores, agora vamos discutir qual é a relação entre definição de tipos de dados e operações com conjunto. \pause

- Os valores possíveis para um tipo definido por uma estrutura (**tipo produto**) é o produto cartesiano dos valores possíveis de cada um do seus campos; \pause

- Os valores possíveis para um tipo definido por uma união (**tipo soma**) é a união dos valores de cada tipo (classe de valores) da união. \pause

- Chamamos de **tipo algébrico de dado** um tipo soma de tipos produtos.


## Uniões e Estruturas

Entender essa relação pode nos ajudar na definição dos tipos de dados, como foi para o quadrado do campo minado e como é para o caso do estado da tarefa. \pause

Antes de vermos como expressar uniões em Racket, vamos ver como uniões funcionam em um sistema estático de tipo (discutido em sala).


## Definição de tipos de dados

Agora podemos prosseguir com o projeto do programa em Racket. \pause

\small

```scheme
(struct executando ())
;; Representa que uma tarefa está em execução.

(struct sucesso (duracao msg))
;; Representa o estado de uma tarefa que finalizou a execução com sucesso.
;; duracao: Número - tempo de execução em segundos
;; msg    : String - mensagem de sucesso gerada pela tarefa

(struct erro (codigo msg))
;; Representa o estado de uma tarefa que finalizou a execução com falha.
;; código: Número - o código da falha
;; msg   : String - mensagem de erro gerada pela tarefa
```

## Definição de tipos de dados

Agora podemos definir o tipo para estado da tarefa como uma união de três casos:

\small

```scheme
;; EstadoTarefa é um dos valores:
;; - (executando)             A tarefa está em execução
;; - (sucesso Número String)  A tarefa finalizou com sucesso
;; - (erro Número String)     A tarefa finalizou com falha
```


## Especificação

\small

```scheme
;; EstadoTarefa -> String
;; Produz uma string amigável para o usuário para descrever o estado da tarefa.
(define (msg-usuario estado) "")
```

\pause

Quantos exemplos são necessários? \pause Pelo menos um para cada classe de valor. \pause (Note que o exercício não é muito específico sobre a saída (o foco é no projeto de dados), por isso usamos a criatividade para definir a saída) \pause

```scheme
(examples
 (check-equal? (msg-usuario (executando))
               "A tarefa está em execução.")
 (check-equal? (msg-usuario (sucesso 12 "Os resultados estão corretos"))
               "Tarefa concluída (12s): Os resultados estão corretos.")
 (check-equal? (msg-usuario (erro 123 "Número inválido '12a'"))
               "A tarefa falhou (err 123): Número inválido '12a'."))
```


## Implementação

Mesmo sem saber detalhes da implementação, podemos definir a estrutura do corpo da função baseado apenas no tipo do dado, no caso, `EstatoTarefa`. \pause São três casos, dependendo do caso, podemos usar seletores específicos.

## Uniões

\small

```scheme
(define (msg-usuario estado)
  (cond
    [(executando? estado)
     ...]
    [(sucesso? estado)
     ...
     ... (sucesso-duracao estado)
     ... (sucesso-msg estado)]
    [(erro? estado)
     ...
     ... (erro-codigo estado)
     ... (erro-msg estado)]))
```


## Implementação

\small

```scheme
(define (msg-usuario estado)
  (cond
    [(executando? estado)
     "A tarefa está em execução."]
    [(sucesso? estado)
     (format "Tarefa concluída (~as): ~a."
             (sucesso-duracao estado)
             (sucesso-msg estado))]
    [(erro? estado)
     (format "A tarefa falhou (err ~a): ~a."
             (erro-codigo estado)
             (erro-msg estado))]))
```


## Considerações

Nos vimos que os tipos algébricos de dados podem ser usados para modelar informações de forma mais precisa, aumentando a confiabilidade do programa. \pause

Mas a sua utilidade pode ser ampliada se a linguagem oferecer algum tipo de verificação estática que suporte tipos algébricos. \pause

Considere por exemplo uma alteração nos requisitos do nosso projeto: as tarefas agora podem ficar em uma fila antes de iniciar a execução. \pause

Supondo que o programa utilize `EstadoTarefa` em mais que um lugar, como podemos saber todos os lugares que precisamos alterar o código para levar em consideração o novo estado "Fila"? \pause

Em Racket não podemos... \pause mas em Typed Racket podemos!


## Uniões em Racket tipado (typed racket)

<div class="columns">
<div class="column" width="40%">

Considere as seguintes definições

\footnotesize

```scheme
#lang typed/racket

(struct executando ())

(struct sucesso ([duracao : Number]
                 [msg : String]))

(struct erro ([codigo : Number]
              [msg : String]))

(define-type EstadoTarefa
  (U executando sucesso erro))
```

</div>
<div class="column" width="56%">

E a função

\footnotesize

```scheme
(: msg-usuario (-> EstadoTarefa String))
(define (msg-usuario estado)
  (cond
    [(executando? estado)
     "A tarefa está em execução"]
    [(sucesso? estado)
     (format "A tarefa finalizou com sucesso (~as): ~a."
             (sucesso-duracao estado)
             (sucesso-msg estado))]
    [(erro? estado)
     (format "A tarefa falhou (erro ~a): ~a."
             (erro-codigo estado)
             (erro-msg estado))]))
```

</div>
</div>


## Uniões em Racket tipado (typed racket)

O que acontece se alteramos a definição do estado da tarefa da seguinte maneira?

\footnotesize

```scheme
(struct fila ())
(define-type EstadoTarefa (U fila executando sucesso erro))
```

\pause

\normalsize

O analisador estático do Racket indica um erro no `cond`{.scheme}, pois nem todos os casos são tratados.

\pause

\footnotesize

```
Type Checker: type mismatch
  expected: String
  given: Void
```



Outras linguagens
=================


## União em outras linguagens

Podemos usar tipos algébricos em outras linguagens? \pause Sim, de fato, com o aumento do uso do paradigma funcional, muitas linguagens, mesmo algumas mais antigas como Java e Python, ganharam suporte a essa forma de definição de tipo de dados. \pause

Vamos ver alguns exemplos.


## Uniões em Python

\footnotesize

```python
@dataclass
class Executando:
    pass

@dataclass
class Sucesso:
    duracao: int
    msg: str

@dataclass
class Erro:
    codigo: int
    msg: str

EstadoTarefa = Executando | Sucesso | Erro
```


## Uniões em Python

\footnotesize

```python
def mensagem(estado: EstadoTarefa) -> str:
    if isinstance(estado, Executando):
        return 'A tarefa está em execução'
    elif isinstance(estado, Sucesso):
        return 'A tafera finalizou com sucesso ({}s): {}'.format(estado.duracao,
                                                                 estado.msg)
    else:
        return 'A tafera falhou (error {}): {}'.format(estado.codigo, estado.msg)
```


## Uniões em Python

\footnotesize

```python
def mensagem(estado: EstadoTarefa) -> str:
    match estado:
        case Executando():
            return 'A tarefa está em execução'
        case Sucesso(duracao, msg):
            return f'A tafera finalizou com sucesso ({duracao}s): {msg}'
        case Erro(codigo, msg):
            return f'A tafera falhou (error {codigo}): {msg}'
```

\pause

Aqui usamos **casamento de padrões** para decompor cada tipo produto em seus componentes.


## Uniões em Rust

\footnotesize

```rust
pub enum EstadoTarefa {
    Executando,
    Sucesso(u32, String),
    Erro(u32, String),
}
pub fn mensagem(estado: &EstadoTarefa) -> String {
    match estado {
        EstadoTarefa::Executando =>
            "A tarefa está em execução".to_string(),
        EstadoTarefa::Sucesso(duracao, msg) =>
            format!("A tarefa finalizou com sucesso ({duracao}s): {msg}"),
        EstadoTarefa::Erro(codigo, msg) =>
            format!("A tarefa falhou (erro {codigo}): {msg}"),
    }
}
```

Usamos novamente casamento de padrões para decompor `Sucesso` e `Erro` em seu componentes.


## Uniões em Java

\footnotesize

```java
sealed interface EstadoTarefa permits Executando, Sucesso, Erro {};
record Executando() implements EstadoTarefa {};
record Sucesso(int duracao, String msg) implements EstadoTarefa {};
record Erro(int erro, String msg) implements EstadoTarefa {};

static String mensagem(EstadoTarefa estado) {
    return switch (estado) {
        case Executando e ->
            "A tarefa está executando";
        case Sucesso s ->
            String.format("A tarefa foi concluída (%ds): %s", s.duracao(), s.msg());
        case Erro e ->
            String.format("A tarefa falhou (erro %d): %s", e.erro(), e.msg());
    };
}
```

A [JEP 405](https://openjdk.org/jeps/405), que ainda está em _preview_, permite o uso de padrões para decompor registros.


## Revisão

Vimos com mais detalhes como desenvolver a etapa de definição de tipos de dados. \pause

Aprendemos que devemos considerar dois princípios no projeto de tipos de dados \pause

- Faça os valores válidos representáveis. \pause
- Faça os valores inválidos irrepresentáveis. \pause

Vimos como definir novos tipos de dados usando tipos algébricos: \pause

- Estruturas (tipo produto) \pause
- Uniões e enumerações (tipo soma)


## Revisão

Discutimos como os tipos de dados guiam o processo de projeto de programas: \pause

- Um tipo soma com N casos sugere pelo menos N exemplos; \pause

- Um tipo soma com N casos sugere um corpo com uma análise de N casos. \pause

Por fim, vimos que um analisador estático amplia bastante a utilidade dos tipos algébricos de dados, garantindo que o código trate todos os casos na análise de tipos soma.



Referências
===========

## Referências

Básicas

- [Vídeos Compound Data](https://www.youtube.com/playlist?list=PL6NenTZG6KrpA-ww35EwcaxY-tgh82TAh)

- [Vídeos Reference](https://www.youtube.com/watch?v=tp44seRHLUQ&list=PL6NenTZG6KrptkOEMyLWDnF0ZjSpVTHAE)

- [Vídeo Making Impossible States Impossible](https://www.youtube.com/watch?v=IcgmSRJHu_8)

- [Seções](http://docs.racket-lang.org/guide/define-struct.html) 5.1 a 5.5 do [Guia Racket](http://docs.racket-lang.org/guide/)


Leitura recomendada

- [Expression problem](https://en.wikipedia.org/wiki/Expression_problem)
