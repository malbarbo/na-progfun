---
# vim: set spell spelllang=pt_br sw=4:
# TODO: frase "Parse, don't validate": In other words, write functions on the data representation you wish you had, not the data representation you are given.
# TODO: em vez de passar a responsabilidade de tratar o erro adiante, empurre-a para trás
title: Funções totais
---

Introdução
==========


## Introdução

No capítulo **Projeto de funções** vimos que a especificação de uma função é um **contrato**: quem usa a função respeita as restrições sobre as entradas, quem implementa cumpre as garantias sobre a saída. \pause

Vimos também que uma função é **parcial** quando existem valores dos tipos das entradas para os quais ela não produz uma resposta válida, e que são justamente esses valores que as restrições excluem. \pause

No capítulo **Tipos de dados** vimos como definir tipos em que os valores inválidos são irrepresentáveis. \pause

Neste capítulo vamos juntar as duas coisas: usar os tipos de dados para eliminar as restrições, transformando funções parciais em **funções totais**.


## Como tornar uma função total

Como transformar uma função parcial em uma função total? \pause Existem três caminhos. \pause

- Escolher uma resposta para as entradas que o contrato hoje proíbe, sem mudar os tipos; \pause

- **Apertar** o tipo da entrada, para que as entradas proibidas deixem de existir; \pause

- **Alargar** o tipo da saída, para que a função tenha uma resposta a mais para dar. \pause

O primeiro não precisa de nenhum tipo novo, então vamos vê-lo agora. Os outros dois são o assunto do restante do capítulo.


## Escolher uma resposta

O caminho mais simples é dar uma resposta às entradas que estavam proibidas, sem mudar tipo nenhum. \pause

\small

```gleam-repl
> string.slice("casa", 0, 10)
"casa"
> 10 / 0
0
```

\normalsize

\pause

A função `string.slice`{.gleam} não exige que a string tenha o tamanho pedido, e o operador `/`{.gleam} não exige que o divisor seja diferente de zero. \pause As duas são totais: não têm restrição nenhuma sobre as entradas.


## Escolher uma resposta

Mas os dois casos não são a mesma coisa. \pause

Em `string.slice`{.gleam} a restrição desaparece de verdade: "os 10 primeiros caracteres, ou a string toda se ela tiver menos que isso" é um propósito mais geral, que continua fazendo sentido. Nada foi inventado. \pause

Já o `0`{.gleam} da divisão por zero é arbitrário: ele não estende o propósito da divisão, é só um valor escolhido para a função ter o que devolver. \pause O erro, que antes estava explícito na especificação, passa a circular pelo programa disfarçado de resposta. \pause

Este caminho é legítimo quando a nova resposta **generaliza o propósito**, e é uma armadilha quando ela apenas **preenche um buraco**. \pause Nesse segundo caso o certo é alargar o tipo da saída, e é por isso que o Gleam oferece o `int.divide`{.gleam} ao lado do `/`{.gleam}.


## Pendências

No capítulo anterior aplicamos com sucesso as diretrizes para projeto de tipos de dados no exemplo do combustível, do quadrado do campo minado e do estado da tarefa. \pause Mas ficaram alguns pontos para resolver. \pause

No problema do combustível usamos `Float`{.gleam} para representar o preço do combustível, mas não garantimos que o preço é maior do que zero. \pause

No problema do estado da tarefa, usamos `Int`{.gleam} para representar a duração da tarefa no caso de sucesso, mas não garantimos que a duração é maior ou igual a zero. \pause

Na função de exemplo `duracao(EstadoTarefa) -> Int`{.gleam}, devolvemos `-1`{.gleam} para representar que o estado da tarefa não tem informação de duração. \pause

Como podemos resolver essas questões? \pause Vamos começar com a função `duracao`{.gleam}.


Valores opcionais
=================


## Valores opcionais

<div class="columns">
<div class="column" width="54%">
\footnotesize

```gleam
/// Devolve -1 se não tem duração.
pub fn duracao(tarefa: EstadoTarefa) -> Int {
  case tarefa {
    Sucesso(duracao, _) -> duracao
    _ -> -1
  }
}
```

```gleam-repl
> duracao(Executando)
-1
> duracao(Sucesso(10, "Recuperação exitosa."))
10
> duracao(Erro(-23, "Arquivo não existente."))
-1
```

\pause

</div>
<div class="column" width="42%">
Como representar um inteiro que pode ou não estar presente? \pause

São dois casos distintos: ou existe um valor, ou não existe valor algum. \pause Então, podemos criar um tipo de união. \pause

\footnotesize

```gleam
pub type Opcional {
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
pub fn duracao(tarefa: EstadoTarefa) -> Opcional {
  case tarefa {
    Sucesso(duracao, _) -> Algum(duracao)
    _ -> Nenhum
  }
}
```

```gleam-repl
> duracao(Executando)
Nenhum
> duracao(Sucesso(10, "Recuperação exitosa."))
Algum(10)
> duracao(Erro(-23, "Arquivo não existente."))
Nenhum
```

\pause

</div>
<div class="column" width="42%">
Quais as vantagens dessa abordagem? \pause

O código é mais claro. \pause

O usuário da função tem de tratar de forma explícita os dois casos; ele não pode usar por "acidente" o valor -1 como se existisse uma duração. \pause

\footnotesize

```gleam-repl
> 2 * duracao(Executando)
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
pub fn soma1(a: Opcional) -> Opcional {
  todo
}
```

\pause

```gleam
pub fn soma1_examples() {
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
pub fn soma1(a: Opcional) -> Opcional {
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
pub type Opcional {
  Nenhum
  Algum(String)
}

/// Devolve o primeiro caractere
/// de *s* ou Nenhum se *s* é vazia.
pub fn primeiro(s: String) -> Opcional {
  todo
}
```

\pause

```gleam
pub fn primeiro_examples() {
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
pub fn primeiro(s: String) -> Opcional {
  case s {
    "" -> Nenhum
    _ -> Algum(string.slice(s, 0, 1))
  }
}
```

\pause

\normalsize

Existe algum problema com essa representação? \pause

O tipo `Opcional`{.gleam} permite `Algum("")`{.gleam}. \pause

Este é o mesmo problema do preço e da duração...
</div>
</div>


## Valores opcionais

Precisamos de uma definição de `Opcional`{.gleam} para cada tipo de conteúdo: `Int`{.gleam}, `String`{.gleam}, ... \pause

Gleam tem na biblioteca padrão o tipo `Option`{.gleam} para representar valores opcionais. \pause


<div class="columns">
<div class="column" width="48%">
O tipo `Option`{.gleam} é definido como

\footnotesize

```gleam
pub type Option(a) {
  None
  Some(a)
}
```

\pause

\normalsize

O nome `a` é um parâmetro de tipo. \pause

Os parâmetros de tipo são escritos com letra minúscula. \pause

Um parâmetro de tipo pode ser instanciado com qualquer tipo. \pause

</div>
<div class="column" width="48%">

\footnotesize

```gleam
import gleam/option.{type Option, Some, None}
```

\pause

```gleam
pub fn soma1(a: Option(Int)) -> Option(Int) {
  case a {
    None -> None
    Some(x) -> Some(x + 1)
  }
}
```

\pause

```gleam
pub fn primeiro(s: String) -> Option(String) {
  case s {
    "" -> None
    _ -> Some(string.slice(s, 0, 1))
  }
}
```
</div>
</div>


## Valores opcionais

As linguagens Rust e Java, entre outras, também têm um tipo para representar valores opcionais: `Option`{.gleam} em Rust e `Optional`{.gleam} em Java. \pause

Em Rust o tipo `Option`{.gleam} é bastante utilizado na biblioteca padrão para representar valores que podem estar ausentes, como na saída de funções semelhantes à função `primeiro`{.gleam}. \pause

Em Gleam, é mais comum utilizar o tipo `Result`{.gleam}, que vamos discutir a seguir.


Erros
=====


## Erros

Como lidar com funções que podem falhar? \pause

Por exemplo, uma função que converte uma string para um número pode falhar, pois nem todas as strings representam números válidos, como lidar com isso? \pause

Estratégias comumente utilizadas incluem \pause

- Finalizar o programa \pause
- Lançar exceção (Python, Java) \pause
- ... \pause
- Devolver um valor indicando erro \pause

Nós vimos que as linguagens puramente funcionais não têm efeitos colaterais, então a opção mais viável é a última.


## Erros

Uma possibilidade é utilizar `Option`{.gleam} como resultado, sendo que `None`{.gleam} representa que a função falhou, e `Some(val)`{.gleam} que a função executou corretamente e produziu `val`{.gleam} como resposta. \pause

Em que situações o tipo `Option`{.gleam} não seria adequado? \pause Quando existe mais de uma possível causa para a falha da função e queremos distinguir entre essas falhas. \pause

Por exemplo, uma função para escrever em um arquivo pode falhar porque o arquivo não existe, o usuário não tem permissão para escrever no arquivo, o disco está cheio, etc. \pause

Como podemos proceder nesse caso?


## Erros

Definimos uma união com dois casos: um para erro, com um valor associado, e outro para sucesso, com um valor associado. \pause

Em Gleam, este é o tipo `Result`{.gleam}, pré-definido como:

\small

```gleam
pub type Result(ok, error) {
  Ok(ok)
  Error(error)
}
```


## Option vs Result

De acordo com <https://hexdocs.pm/gleam_stdlib/gleam/option.html>:

*In other languages, fallible functions may return either `Result` or `Option` depending on whether there is more information to be given about the failure. In Gleam all fallible functions return `Result`, and `Nil` is used as the error if there is no extra detail to give. This consistency removes the boilerplate that would otherwise be needed to convert between `Option` and `Result` types, and makes APIs more predictable.*


## Erros

<div class="columns">
<div class="column" width="48%">
\small

```gleam-repl
> int.parse("10.1")
Error(Nil)
> int.parse("241")
Ok(241)
```

\pause

```gleam-repl
> int.divide(25, 3)
Ok(8)
> int.divide(12, 0)
Error(Nil)
```

\pause

</div>
<div class="column" width="48%">
\small

```gleam-repl
> float.square_root(25.0)
Ok(5.0)
> float.square_root(-1.0)
Error(Nil)
```

\pause

```gleam-repl
> string.first("")
Error(Nil)
> string.first("casa")
Ok("c")
```

</div>
</div>


## Exemplo - soma de string

Projete uma função que receba como parâmetro duas strings, e, se as duas representarem inteiros, devolva a soma dos seus valores em forma de string.


## Exemplo - soma de string

<div class="columns">
<div class="column" width="48%">
\footnotesize

```gleam
pub fn soma(
  a: String,
  b: String,
) -> Result(String, Nil) {
  todo
}
```

\pause

```gleam
pub fn soma_examples() {
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
pub fn soma(a, b) -> Result(String, Nil) {
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
pub fn soma(a, b) -> Result(String, Nil) {
  case int.parse(a), int.parse(b) {
    Ok(a), Ok(b) -> Ok(int.to_string(a + b))
    _, _ -> Error(Nil)
  }
}
```
</div>
</div>


Validação
=========


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
pub type Preco = Float

pub fn seleciona_combustivel(
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

Em todos os lugares em que `Preco`{.gleam} é utilizado, precisamos fazer a validação; \pause ou podemos assumir que o preço foi validado anteriormente. \pause

Podemos melhorar? \pause Sim!

</div>
</div>


## Validação

A ideia é definir um TAD, e fazer a validação do valor no construtor do tipo. \pause

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
pub fn seleciona_combustivel(
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
pub fn seleciona_combustivel_examples() {
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


## Validação

Com isso, fechamos as três pendências: \pause

- O preço do combustível é validado no construtor do tipo opaco `Preco`{.gleam}; \pause

- A duração da tarefa se resolve da mesma forma, com um tipo opaco `Duracao`{.gleam} cujo construtor devolve `Error(Nil)`{.gleam} para valores negativos; \pause

- A função `duracao`{.gleam} devolve `Option(Int)`{.gleam} em vez de usar `-1`{.gleam} para indicar a ausência de valor.


Revisão
=======


## Revisão

Quais são os três caminhos para transformar uma função parcial em uma função total? \pause

- Escolher uma resposta para as entradas que o contrato proíbe, apertar o tipo da entrada ou alargar o tipo da saída. \pause

Quando escolher uma resposta para as entradas proibidas é uma boa ideia? \pause

- Quando a nova resposta generaliza o propósito da função, como em `string.slice`{.gleam}. Quando ela apenas preenche um buraco, como o `0`{.gleam} da divisão por zero, o erro fica escondido e é melhor alargar o tipo da saída.


## Revisão

Como representar um valor que pode estar ausente? \pause

- Com o tipo `Option`{.gleam}, que tem os casos `None`{.gleam} e `Some(a)`{.gleam}. \pause

Como representar o resultado de uma função que pode falhar? \pause

- Com o tipo `Result`{.gleam}, que tem os casos `Ok(ok)`{.gleam} e `Error(error)`{.gleam}. Em Gleam, toda função que pode falhar devolve `Result`{.gleam}. \pause

Como garantir que só é possível criar valores válidos de um tipo? \pause

- Definindo um tipo opaco e fazendo a validação na função que constrói o valor, que devolve `Result`{.gleam}.


Referências
===========

## Referências

Básicas

- [Tipos opacos em Gleam](https://tour.gleam.run/everything/#advanced-features-opaque-types)

- [Módulo option](https://hexdocs.pm/gleam_stdlib/gleam/option.html) da biblioteca padrão

- [Módulo result](https://hexdocs.pm/gleam_stdlib/gleam/result.html) da biblioteca padrão

Complementares

- [Parse, don't validate](https://lexi-lambda.github.io/blog/2019/11/05/parse-don-t-validate/)
