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
# TODO: usar o termo registro ao invés de estrutura?
# TODO: falar de tuplas
# TODO: mostrar a solução completa para custo_tiquetes
# TODO: deixar claro: funções totais
# TODO: frase "Parse, don´t validade": In other words, write functions on the data representation you wish you had, not the data representation you are given.
# TODO: ao invés de passar a responsabilidade de tratar o erro adiante, empure ela para trás
# TODO: separar em dois decks: projeto de tipos de dados e projeto de funções completas?
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

Um inteiro é adequado para representar a quantidade de pessoas em um planeta? \pause

- Não é adequado pois ele pode ser negativo, mas a quantidade de pessoas em um planeta não pode, ou seja, o tipo permite representar valores inválidos. \pause

E um natural de 32 bits? \pause

- Não é adequado pois o valor máximo possível é 4.294.967.295, mas o planeta terra tem mais pessoas que isso, ou seja, o tipo não permite representar todos os valores válidos. \pause

E um natural? \pause

- É adequado. Cada valor do conjunto dos naturais representa um valor válido de informação, e cada possível valor de informação pode ser representado por um número natural.


## Diretrizes para o projeto de tipos de dados

Diretrizes para o projeto de tipos de dados: \pause

- Faça os valores válidos representáveis. \pause

- Faça os valores inválidos irrepresentáveis. \pause

Vamos aplicar esses princípios a uma série de exemplos.


## Exemplo combustível

No exemplo da escolha do combustível, nós definimos os seguintes tipos:

\small

```gleam
/// O preço do litro do combustível, deve ser um número positivo.
type Preco = Float

/// O tipo do combustível, deve "Alcool" ou "Gasolina".
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

Em um **tipo enumerado** todos os valores do tipo são enumerados explicitamente. \pause

A forma geral para definir tipos enumerados é:

\small

```gleam
[pub] type NomeDoTipo {
  Valor1
  Valor2
  ...
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
/// O tipo de usuário do RU da UEM.
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
    Aluno -> todo
    ServidorAte3 -> todo
    ServidorMais3 -> todo
    Docente -> todo
    Externo -> todo
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

Chamamos estes tipos de dados de **dados compostos**, **registro** ou **estruturas**.


## Estruturas

A forma geral para definir um **dado composto** é:

```gleam
[pub] type Nome {
  Nome([campo1:] Tipo1, [campo2:] Tipo2, ...)
}
```

\pause

Vamos definir uma estrutura para representar um ponto em um plano cartesiano.


## Estruturas - operações

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
> let p1: Ponto = Ponto(x: 3, y: 4)
> let p2 = Ponto(8, 2)
> p2
Ponto(x: 8, y: 2)
```

\pause

Acesso aos campos

```scheme
> p1.x + p1.y
7
```

</div>
<div class="column" width="48%">

\small

\pause

Desestruturação

```gleam
> // pela posição
> let Ponto(x, y) = p2
> x
8
> y
2
```

\pause

```gleam
// pelo rótulo
> let Ponto(y: a, ..) = p2
> a
2
> let Ponto(y:, ..) = p2
> y
2
```
</div>
</div>


## Estruturas - operações

<div class="columns">
<div class="column" width="48%">
\small

Definição

```gleam
type Ponto {
  Ponto(x: Int, y: Int)
}
```

Construção

```gleam
> let p1: Ponto = Ponto(x: 3, y: 4)
> let p2 = Ponto(8, 2)
> p2
Ponto(x: 8, y: 2)
```

Acesso aos campos

```scheme
> p1.x + p1.y
7
```
</div>
<div class="column" width="48%">

\small

Comparação

```gleam
> p1 == Ponto(3, 4)
True
> p1 != p1
False
> p1 != p2
True
```

\pause

Inspeção

```gleam
> string.inspect(p1)
"Ponto(x: 3, x: 4)"
```
</div>
</div>



## Definindo estruturas

Junto com a definição de uma estrutura, também faremos a descrição do seu propósito e do seus campos.

\pause

\small

```gleam
/// Um ponto no plano cartesiano.
type Ponto {
  // x e y são as coordenadas dos pontos.
  Ponto(x: Int, y: Int)
}
```


## Atualização de dados compostos

Podemos consultar o valor de um campo, mas como alterar o valor de um campo? \pause Não tem como! \pause Lembrem-se, estamos estudando o paradigma funcional, onde não existe mudança de estado! \pause

Ao invés de modificar o campo de uma instância da estrutura, criamos uma cópia da instância com o campo alterado.

\pause

Vamos criar um ponto `p2` que é como `p1`, mas com o valor 5 para o campo `y`. \pause

\small

```gleam
> let p1 = Ponto(3, 4)
> let p2 = Ponto(p1.x, 5)
> p2
Ponto(x: 3, y: 5)
```


## Alterando dados estruturados

Quais são as limitações desse método? \pause

- Se a estrutura tem muitos campos e desejamos alterar apenas um campo, temos que especificar a cópia de todos os outros; \pause

- Se a estrutura é alterada pela adição ou remoção de campos, então, todas as operações de "cópia" da estrutura no código devem ser alteradas.


## Alterando dados estruturados

Gleam tem uma sintaxe especial para atualização de estruturas.

\pause

\small

```gleam
> let p1 = Ponto(3, 4)
> let p2 = Ponto(..p1, y: 5)
> p2
Ponto(x: 3, y: 5)
```

\pause

```gleam
> let p3 = Ponto(..p1, x: 7)
> p3
Ponto(x: 7, y: 4)
```

\pause

```gleam
> // Podemos atualiza mais que um campo (não faz sentido nesse exemplo)
> Ponto(..p1, x: 1, y: 2)
Ponto(x: 1, y: 2)
```


## Exemplo - outras linguagens

A ideia de estruturas imutáveis que são "atualizadas" através de cópias está presente em diversas linguagens. \pause A seguir temos um exemplo em Python e outro em Rust.

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


<!--
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

-->


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

```gleam
/// Um quadrado no jogo campo minado.
pub type Quadrado {
  Quadrado(mina: Bool, aberto: Bool, bandeira: Bool)
}
```


## Exemplo - Campo minado

Nós vimos duas diretrizes para o projeto de tipo de dado

- Faça os valores válidos representáveis.
- Faça os valores inválidos irrepresentáveis. \pause

A definição de `Quadrado`{.gleam} está de acordo com essas diretrizes? \pause Vamos verificar! \pause

Quantas possíveis instâncias distintas existem de `Quadrado`{.gleam}? \pause São três campos, cada um pode assumir dois valores, portanto, $2 \times 2 \times 2 = 8$. \pause

Vamos listar essas instâncias e analisar se todas são válidas.


## Exemplo - Campo minado

<div class="columns">
<div class="column" width="48%">

\small

| `mina?`     | `aberto?`    | `bandeira?` | Válido?     |
|:-----------:|:------------:|:-----------:|:-----------:|
|      F      |      F       |      F      | \pause Sim \pause |
|      F      |      F       |      V      | \pause Sim \pause |
|      F      |      V       |      F      | \pause Sim \pause |
|      F      |      V       |      V      | \pause Não \pause |
|      V      |      F       |      F      | \pause Sim \pause |
|      V      |      F       |      V      | \pause Sim \pause |
|      V      |      V       |      F      | \pause Sim \pause |
|      V      |      V       |      V      | \pause Não        |

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

<div class="columns">
<div class="column" width="48%">
\small

```gleam
/// O estado de um quadrado no
/// campo do jogo.
pub type Estado {
  Aberto
  Fechado
  FechadoComBandeira
}

/// Um quadrado no campo de jogo.
pub type Quadrado {
  // True se tem mina,
  // False caso contrário.
  Quadrado(mina: Bool, estado: Estado)
}
```

</div>
<div class="column" width="48%">

\pause

Quantas possíveis instâncias distintas existem de `Quadrado`{.gleam}? \pause O campo `mina` pode assumir dois valores e o campo `estado` 3, portanto, $2 \times 3 = 6$, que são os seis estados válidos que identificamos anteriormente.

</div>
</div>


## Exemplo - Ação campo minado

Agora que temos uma representação adequada para um quadrado, podemos avançar e projetar uma função que determina como um quadrado ficará após a ação de um usuário. O usuário pode fazer uma ação para abrir um quadrado, adicionar uma bandeira ou remover uma bandeira.


## Exemplo - Ação campo minado

Análise \pause

- Determinar o novo estado de um quadrado a partir da ação do usuário \pause

Definição de tipos de dados \pause

\small

```gleam
/// Uma ação do usuário no jogo.
pub type Acao {
  Abrir
  AdicionarBandeira
  RemoverBandeira
}
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
| fechado \pause             |    aberto      | fechado com bandeira |      - \pause |
| fechado com bandeira \pause|      -         |       -              |   fechado     |

\pause

\footnotesize

```gleam
check.eq(
  atualiza_quadrado(Quadrado(False, Aberto), Abrir),
```

\vspace{-0.6cm}

\pause

```gleam
  Quadrado(False, Aberto)
) // q
```

\pause

```gleam
check.eq(
  atualiza_quadrado(Quadrado(False, Fechado), Abrir),
```

\vspace{-0.6cm}

\pause

```gleam
  Quadrado(False, Aberto)
) // Quadrado(..q, estado: Aberto)
```


## Exemplo - Ação campo minado

Implementação \pause

Se o comportamento de uma função depende apenas de um valor enumerado, qual é a estrutura inicial do corpo da função? \pause Um caso para cada valor enumerado. \pause

A função que estamos projetando depende de dois valores enumerados, qual deve ser a estrutura inicial do corpo da função? \pause Uma seleção de dois níveis, cada nível para um valor enumerado; \pause ou; uma seleção com uma condição para cada par dos valores enumerados.


## Exemplo - Ação campo minado

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
fn atualiza_quadrado(q: Quadrado, acao: Acao) {
  case q.estado {
    Aberto -> case acao {
      Abrir -> todo
      AdicionarBandeira -> todo
      RemoverBandeira -> todo
    }
    Fechado -> case acao {
      Abrir -> todo
      AdicionarBandeira -> todo
      RemoverBandeira -> todo
    }
    FechadoComBandeira -> case acao {
      Abrir -> todo
      AdicionarBandeira -> todo
      RemoverBandeira -> todo
    }
  }
}
```

\pause

</div>
<div class="column" width="48%">
\scriptsize

```gleam
fn atualiza_quadrado(q: Quadrado, acao: Acao) {
  case q.estado, acao {
    Aberto, Abrir -> todo
    Aberto, AdicionarBandeira -> todo
    Aberto, RemoverBandeira -> todo
    Fechado, Abrir -> todo
    Fechado, AdicionarBandeira -> todo
    Fechado, RemoverBandeira -> todo
    FechadoComBandeira, Abrir -> todo
    FechadoComBandeira, AdicionarBandeira -> todo
    FechadoComBandeira, RemoverBandeira -> todo
  }
}
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

```gleam
pub fn atualiza_quadrado(q: Quadrado, acao: Acao) -> Quadrado {
  case q.estado, acao {
    Fechado, Abrir -> Quadrado(..q, estado: Aberto)
    Fechado, AdicionarBandeira -> Quadrado(..q, estado: FechadoComBandeira)
    FechadoComBandeira, RemoverBandeira -> Quadrado(..q, estado: Fechado)
    _, _ -> q
  }
}
```


Uniões
======


## Exemplo - Estado tarefa

Projete uma função que exiba uma mensagem sobre o estado de uma tarefa. Uma tarefa pode estar em execução, ter sido concluída em uma duração específica e com um mensagem de sucesso, ou ter falhado com um código e uma mensagem de erro.

\pause

Como representar o estado de uma tarefa? \pause

Vamos tentar uma estrutura.


## Exemplo - Estado tarefa

\footnotesize

```gleam
/// O estado de uma tarefa.
type EstadoTarefa {
  EstadoTarefa(
    // True se a tarefa está em execução, False caso contrário.
    executando: Bool,
    // Em caso de sucesso
    duracao: Int,
    msg_sucesso: String,
    // Em caso de erro
    codigo_erro: Int,
    msg_erro: String
  )
}
```

\pause

\normalsize

Qual é o problema dessa representação? \pause Possíveis estados inválidos. \pause O que significa
\footnotesize `EstadoTarefa(True, 10, "Ótimo desempenho", 123, "Falha na conexão")`{.gleam}?


## Exemplo - Estado tarefa

Analisando a descrição do problema conseguimos separar o estado da tarefa em três casos: \pause

- Em execução \pause
- Sucesso, com uma duração e uma mensagem \pause
- Falha, com um código e uma mensagem \pause

Esses casos são excludentes, ou seja, se a tarefa se enquadra em um deles, não devemos armazenar informações sobre os outros (caso contrário, seria possível criar um estado inconsistente). \pause

E como expressar esse tipo de dado? \pause Usando união de tipos.


## Uniões e Estruturas

Definimos anteriormente um tipo de dado como um conjunto de possíveis valores, agora vamos discutir qual é a relação entre definição de tipos de dados e operações com conjunto. \pause

- Os valores possíveis para um tipo definido por uma estrutura (**tipo produto**) é o produto cartesiano dos valores possíveis de cada um do seus campos; \pause

- Os valores possíveis para um tipo definido por uma união (**tipo soma**) é a união dos valores de cada tipo (classe de valores) da união. \pause

- Chamamos de **tipo algébrico de dado** um tipo soma de tipos produtos. \pause

Entender essa relação pode nos ajudar na definição dos tipos de dados, como foi para o quadrado do campo minado e como é para o caso do estado da tarefa.


## Uniões

Algumas linguagens, como Rust e Python, tem maneiras diferentes para definir tipos de dados. \pause

A maioria das linguagens funcionais, incluindo o Gleam, tem apenas uma. \pause

A forma geral para definição de tipos de dados em Gleam é

\small

```gleam
[pub | pub opaque] type Nome {
  Caso1[([campo1:] Tipo1, [campo1:] Tipo2, ...)]
  Caso2[([campo1:] Tipo1, [campo1:] Tipo2, ...)]
  ...
}
```


## Exemplo - Estado tarefa

<div class="columns">
<div class="column" width="43%">
\footnotesize

```gleam
/// O estado de uma tarefa
type EstadoTarefa {
  // A tarefa está em execução
  Executando
  // A tarefa finalizou com sucesso
  Sucesso(duracao: Int, msg: String)
  // A tarefa finalizou com falha
  Falha(codigo: Int, msg: String)
}
```

</div>
<div class="column" width="52%">

\footnotesize

```gleam
> let tarefa: EstadoTarefa = Executado
Executando
```

\pause

```
> tarefa.msg
1 │     tarefa.msg
  │           ^^^^ This field does not exist
```

\pause

\ \

```gleam
> let tarefa = Sucesso(10, "Recuperação exitosa.")
Sucesso(duracao: 10, msg: "Recuperação exitosa.")
```

\pause

```
> tarefa.msg
1 │     tarefa.msg
  │           ^^^^ This field does not exist
```

\pause

</div>
</div>

\ \

Como podemos acessar os campos então!? \pause Usando casamento de padrão com o `case`{.gleam}.


## Exemplo - Estado tarefa

<div class="columns">
<div class="column" width="43%">
\footnotesize

```gleam
/// O estado de uma tarefa
type EstadoTarefa {
  // A tarefa está em execução
  Executando
  // A tarefa finalizou com sucesso
  Sucesso(duracao: Int, msg: String)
  // A tarefa finalizou com falha
  Falha(codigo: Int, msg: String)
}
```

</div>
<div class="column" width="52%">

\footnotesize

```gleam
> // Devolve -1 se não tem duracao.
> fn duracao(tarefa: EstadoTarefa) -> Int {
  case tarefa {
    Sucesso(duracao, _) -> duracao
    _ -> -1
  }
}
```

\pause

\ \

```gleam
> duracao(Executando)
-1
> duracao(Sucesso(10, "Recuperação exitosa."))
10
> duracao(Falha(-23, "Arquivo não existente."))
-1
```

</div>
</div>


## Exemplo - Estado tarefa

Agora podemos retornar e concluir o projeto. \pause

Projete uma função que exiba uma mensagem sobre o estado de uma tarefa. Uma tarefa pode estar em execução, ter sido concluída em uma duração específica e com um mensagem de sucesso, ou ter falhado com um código e uma mensagem de erro. \pause

Especificação

\small

```gleam
/// Produz uma string amigável para o usuário para descrever o estado da tarefa.
fn msg(tarefa: EstadoTarefa) -> String
```

\pause

\normalsize

O exercício não é muito específico sobre a saída (o foco é no projeto de dados), por isso usamos a criatividade para definir a saída nos exemplos a seguir.


## Exemplo - Estado tarefa

Quantos exemplos são necessários? \pause Pelo menos um para cada classe de valor. \pause

\small

```gleam
fn msg_examples() {
  check.eq(
    mensagem(Executando),
    "A tarefa está em execução."
  )
  check.eq(
    mensagem(Sucesso(12, "Os resultados estão corretos.")),
    "Tarefa concluída (12s): Os resultados estão corretos."
  )
  check.eq(
    mensagem(Erro(123, "Número inválido '12a'.")),
    "A tarefa falhou (erro 123): Número inválido '12a'."
  )
}
```

## Exemplo - Estado tarefa

Mesmo sem saber detalhes da implementação, podemos definir a estrutura do corpo da função baseado apenas no tipo do dado, no caso, `EstatoTarefa`. \pause São três casos: \pause

\small

```gleam
fn mensagem(estado: EstadoTarefa) -> String {
  case estado {
    Executando -> todo

    Sucesso(duracao, msg) -> todo

    Erro(codigo, msg) -> todo

  }
}
```


## Exemplo - Estado tarefa

Mesmo sem saber detalhes da implementação, podemos definir a estrutura do corpo da função baseado apenas no tipo do dado, no caso, `EstatoTarefa`. São três casos:

\small

```gleam
fn mensagem(estado: EstadoTarefa) -> String {
  case estado {
    Executando ->
      "A tarefa está em execução."
    Sucesso(duracao, msg) ->
      "Tarefa concluída (" <> int.to_string(duracao) <> "s): " <> msg
    Erro(codigo, msg) ->
      "A tarefa falhou (erro " <> int.to_string(codigo) <> "): " <> msg
  }
}
```


<!--
## Considerações

Nos vimos que os tipos algébricos de dados podem ser usados para modelar informações de forma mais precisa, aumentando a confiabilidade do programa. \pause

Mas a sua utilidade pode ser ampliada se a linguagem oferecer algum tipo de verificação estática que suporte tipos algébricos. \pause

Considere por exemplo uma alteração nos requisitos do nosso projeto: as tarefas agora podem ficar em uma fila antes de iniciar a execução. \pause

Supondo que o programa utilize `EstadoTarefa` em mais que um lugar, como podemos saber todos os lugares que precisamos alterar o código para levar em consideração o novo estado "Fila"? \pause

Em Racket não podemos... \pause mas em Typed Racket podemos!
-->


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



Valores opcionais e erros
=========================


## Pendências

Nós aplicamos com sucesso as diretrizes para projeto de tipos de dados no exemplo do combustível, quadrado do campo minado e estado da tarefa. \pause Mas ainda temos alguns pontos para resolver. \pause

No problema do combustível usamos `Float`{.gleam} para representar o preço do combustível, mas não garantimos que o preço é maior do que zero. \pause

No problema do estado da tarefa, usamos `Int`{.gleam} para representar a duração da tarefa no caso de sucesso, mas não garantimos que a duração é maior ou igual a zero. \pause

Na função exemplo `duracao(EstadoTarefa) -> Int`{.gleam}, devolvemos `-1`{.gleam} para representar que o estado da tarefa não tem informação de duração. \pause

Como podemos resolver essas questões? \pause Vamos começar com a função `duracao`{.gleam}.


## Valores opcionais

<div class="columns">
<div class="column" width="54%">
\footnotesize

```gleam
/// Devolve -1 se não tem duracao.
fn duracao(tarefa: EstadoTarefa) -> Int {
  case tarefa {
    Sucesso(duracao, _) -> duracao
    _ -> -1
  }
}

> duracao(Executando)
-1
> duracao(Sucesso(10, "Recuperação exitosa."))
10
> duracao(Falha(-23, "Arquivo não existente."))
-1
```

\pause

</div>
<div class="column" width="42%">
Como representar um inteiro que pode ou não estar presente? \pause

São dois casos distintos, ou existe um valor, ou não existe nenhum. \pause Então podemos criar um tipo união. \pause

\footnotesize

```gleam
type Opcional {
    Nenhum
    Algum(Int)
}
```

</div>
</div>


## Valores opcionais

<div class="columns">
<div class="column" width="54%">
\footnotesize

```gleam
fn duracao(tarefa: EstadoTarefa) -> Opcional {
  case tarefa {
    Sucesso(duracao, _) -> Algum(duracao)
    _ -> Nenhum
  }
}

> duracao(Executando)
Nenhum
> duracao(Sucesso(10, "Recuperação exitosa."))
Algum(10)
> duracao(Falha(-23, "Arquivo não existente."))
Nenhum
```

\pause

</div>
<div class="column" width="42%">
Quais as vantagens dessa abordagem? \pause

O código é mais claro. \pause

O usuário da função tem que tratar de forma explícita os dois casos, ele não pode usar por "acidente" o valor -1 como se existisse uma duração. \pause

\footnotesize

```gleam
> 2 * duracao(Executado)
```

\pause

```
The * operator expects arguments of
this type:
    Int
But this argument has this type:
    Opcional
```


</div>
</div>

## Soma um

Projete uma função que receba um opcional e some 1 ao valor se ele estiver presente.

\pause

<div class="columns">
<div class="column" width="48%">
\footnotesize

```gleam
/// Soma 1 ao valor opcional de *a*.
fn soma1(a: Opcional) -> Opcional {
  Nenhum
}
```

\pause

```gleam
fn soma1_examples() {
  check.eq(soma1(Nenhum), Nenhum)
  check.eq(soma1(Algum(10)), Algum(11))
}
```

\pause

</div>
<div class="column" width="48%">
\footnotesize

```gleam
/// Soma 1 ao valor opcional de *a*.
fn soma1(a: Opcional) -> Opcional {
  case a {
    Nenhum -> Nenhum
    Algum(x) -> Algum(x + 1)
  }
}
```
</div>
</div>


## Primeiro string

Projete uma função que devolva o primeiro caractere de uma string.

\pause

<div class="columns">
<div class="column" width="48%">
\footnotesize

```gleam
type Optional {
  Nenhum
  Algum(String)
}

/// Devolve o primeiro caractere
/// de *s* ou Nenhum se *s* é vazia.
fn primeiro(s: String) -> Opcional {
  Nenhum
}
```

\pause

```gleam
fn primeiro_examples() {
  check.eq(primeiro(""), Nenhum)
  check.eq(primeiro("casa"), Algum("c"))
}
```

\pause

</div>
<div class="column" width="48%">
\footnotesize

```gleam
/// Devolve o primeiro caractere
/// de *s* ou Nenhum se *s* é vazia.
fn primeiro(s: String) -> Opcional {
  case s {
    "" -> Nenhum
    _ -> Algum(string.slice(s, 0, 1))
  }
}
```

\pause

\normalsize

Existe algum problema com a implementação? \pause

A string em `Opcional`{.gleam} ainda pode ser vazia. \pause

Este é o mesmo problema do preço e da idade...
</div>
</div>


## Valores opcionais

Gleam tem na biblioteca padrão o tipo `Option`{.gleam} para representar valores opcionais. \pause


<div class="columns">
<div class="column" width="48%">
O tipo `Option`{.gleam} é definido como

\footnotesize

```gleam
type Option(a) {
  None
  Some(a)
}
```

\pause

\normalsize

O nome `a` é um parâmetro de tipo. \pause

Os parâmetros de tipos são escritos com letra minúscula. \pause

Um parâmetro de tipo pode ser instanciado com qualquer tipo. \pause

</div>
<div class="column" width="48%">

\footnotesize

```gleam
import gleam/option.{type Option, Some, None}
```

\pause

```gleam
fn soma1(a: Option(Int)) -> Option(Int) {
  case a {
    None -> None
    Some(x) -> Some(x + 1)
  }
}
```

\pause

```gleam
fn primeiro(s: String) -> Option(String) {
  case s {
    "" -> None
    _ -> Some(string.slice(s, 0, 1))
  }
}
```
</div>
</div>


## Valores opcionais

As linguagens Rust e Java, entre outras, também têm o tipo `Option`{.gleam}. \pause

Em Rust o tipo `Option`{.gleam} é bastante utilizando na biblioteca padrão para representar valores que podem estar ausentes, como na saída de funções semelhantes a função `primeiro`{.gleam}. \pause

Em Gleam é mais comum utilizar o tipo `Result`{.gleam}, que vamos discutir a seguir.


## Erros

Como lidar com funções que podem falhar? \pause

Por exemplo, uma função que converte uma string para um número pode falhar, pois nem todas as strings representam números válidos, como lidar com isso? \pause

Estratégias comumente utilizadas incluem \pause

- Finalizar o programa \pause
- Lançar exceção (Python, Java) \pause
- ... \pause
- Devolver um valor indicando erro \pause

Nos vimos que as linguagens puramente funcionais não têm efeitos colaterais, então a opção mais viável é a última.


## Erros

Uma possibilidade é utilizar `Option`{.gleam} como resultado sendo que o `None`{.gleam} representa que a função falhou e `Some(val)`{.gleam} que a função executou corretamente e produziu `val` como resposta. \pause

Em que situações o tipo `Option`{.gleam} não seria adequado? \pause Quando existe mais de uma possível causa para a falha da função e queremos distinguir entre as falhas. \pause

Por exemplo, uma função para escrever em um arquivo pode falhar porque o arquivo não existe, o usuário não tem permissão para escrever no arquivo, o disco está cheio, etc. \pause

Como podemos fazer nesse caso?


## Erros

Definimos uma enumeração com dois casos, uma para erro com um valor associado, e um para sucesso com o valor associado. \pause

Em Gleam, este é o tipo `Result`{.gleam}, pré-definido como:

\small

```gleam
type Result(ok, error) {
    Ok(ok)
    Error(error)
}
```


## Option vs Result

De acordo com <https://hexdocs.pm/gleam_stdlib/gleam/option.html>:

*In other languages failible functions may return either `Result` or `Option` depending on whether there is more information to be given about the failure. In Gleam all failible functions return `Result`, and `Nil` is used as the error if there is no extra detail to give. This consistency removes the boilerplate that would otherwise be needed to convert between `Option` and `Result` types, and makes APIs more predictable.*


## Erros

<div class="columns">
<div class="column" width="48%">
\small

```gleam
> int.parse("10.1")
Error(Nil)
> int.parse("241")
Ok(241)
```

\pause

```gleam
> int.divide(25, 3)
Ok(8)
> int.divide(12, 0)
Error(Nil)
```

\pause

</div>
<div class="column" width="48%">
\small

```gleam
> float.square_root(25.0)
Ok(5.0)
> float.square_root(-1.0)
Error(Nil)
```

\pause

```gleam
> string.first("")
Error(Nil)
> string.first("casa")
Ok("c")
```

</div>
</div>


## Exemplo soma de string

Projete uma função que receba como parâmetro duas strings, e se as duas representarem inteiros, devolva a soma dos valores em forma de string.


## Exemplo soma de string

<div class="columns">
<div class="column" width="48%">
\footnotesize

```gleam
fn soma(
  a: String,
  b: String,
) -> Result(String, Nil) {
  Error(Nil)
}
```

\pause

```gleam
fn soma_examples() {
  check.eq(soma("31", "4"), Ok("35"))
  check.eq(soma("31", "a"), Error(Nil))
  check.eq(soma("a", "4"), Error(Nil))
  check.eq(soma("a", "b"), Error(Nil))
}
```

\pause

</div>
<div class="column" width="48%">
\footnotesize

```gleam
fn soma(a, b) -> Result(String, Nil) {
  case int.parse(a) {
    Ok(a) -> case int.parse(b) {
      Ok(b) -> Ok(int.to_string(a + b))
      Error(_) -> Error(Nil)
    }
    Error(_) -> Error(Nil)
  }
}
```

\pause

```gleam
fn soma(a, b) -> Result(String, Nil) {
  case int.parse(a), int.parse(b) {
    Ok(a), Ok(b) -> Ok(int.to_string(a + b))
    _, _ -> Error(Nil)
  }
}
```
</div>
</div>


## Validação

Como podemos utilizar o tipo `Result`{.gleam} para lidar com a questão do preço, que deve ser positivo? \pause

A opção mais direta é validar o preço na função `seleciona_combustivel`{.gleam} e devolver `Error`{.gleam} se um dos preços não for positivo.


## Validação

<div class="columns">
<div class="column" width="48%">
\footnotesize

```gleam
/// O preço do litro do combustível,
/// deve ser um número positivo.
type Preco = Float

fn seleciona_combustivel(
  preco_alcool: Preco,
  preco_gasolina: Preco,
) -> Result(Combustivel, Nil) {
  case preco_alcool <= 0.0 ||
       preco_gasolina <= 0.0 {
    True -> Error(Nil)
    False -> todo
  }
}
```

\pause

</div>
<div class="column" width="48%">

Qual é a limitação dessa abordagem? \pause

Em todos os lugares que `Preco`{.gleam} é utilizado precisamos fazer a validação; \pause ou podemos assumir que o preço foi validado anteriormente. \pause

Podemos melhorar? \pause Sim!

</div>
</div>


## Validação

A idade é definir um TAD, e fazer a validação do valor no construtor do tipo. \pause

Dessa forma, não é possível construir uma instância do tipo que seja inválida. \pause

Usamos a palavra chave `opaque`{.gleam} para criar um TAD em Gleam. \pause

Apenas o módulo que define um tipo `opaque`{.gleam} tem acesso aos seus componentes.


## Validação

<div class="columns">
<div class="column" width="52%">
\footnotesize

```gleam
/// O preço do litro do combustível.
pub opaque type Preco {
    Preco(valor: Float)
}
```

\pause

```gleam
/// Devolve Ok(Preco) com o valor *v* se
/// v > 0, Error(Nil) caso contrário.
pub fn preco(v: Float) -> Result(Preco, Nil) {
  case v >. 0.0 {
    True -> Ok(Preco(v))
    False -> Error(Nil)
  }
}
```

\pause

```gleam
/// Devolve o valor em *p*.
pub fn valor(p: Preco) -> Float {
  p.valor
}
```

\pause

</div>
<div class="column" width="44%">

\footnotesize

```gleam
fn seleciona_combustivel(
  preco_alcool: Preco,
  preco_gasolina: Preco,
) -> Combustivel {
  case valor(preco_alcool) <=.
         0.7 *. valor(preco_gasolina) {
    ...
  }
}
```

\pause

```gleam
fn seleciona_combustivel_examples() {
  let assert Ok(alcool) = preco(4.2)
  let assert Ok(gasolina) = preco(6.1)
  check.eq(
    seleciona_combustivel(alcool, gasolina),
    Alcool,
  )
}
```

</div>
</div>


Revisão
=======


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


Vimos como usar tipos somas para lidar com valores opcionais, erros e validação: \pause

- O tipo `Option` é usado para valores opcionais; \pause
- O tipo `Result` é utilizado para representar sucesso ou falha de uma função; \pause
- Tipos opacos podem ser utilizados para representar valores que foram validados.


Referências
===========

## Referências

Básicas

- [Tipos de dados em Gleam](https://tour.gleam.run/everything/#data-types-tuples)

- [Tipos opacos em Gleam](https://tour.gleam.run/everything/#advanced-features-opaque-types)

- [Vídeo Making Impossible States Impossible](https://www.youtube.com/watch?v=IcgmSRJHu_8)

- [Parse, don't validade](https://lexi-lambda.github.io/blog/2019/11/05/parse-don-t-validate/)


Leitura recomendada

- [Expression problem](https://en.wikipedia.org/wiki/Expression_problem)
