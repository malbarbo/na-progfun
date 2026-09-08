---
# vim: set spell spelllang=pt_br sw=4:
title: Funções totais
---

Introdução
==========


## Introdução

No capítulo **Projeto de funções** vimos que a especificação de uma função é um **contrato** entre quem usa a função, que deve respeitar as restrições sobre as entradas, e quem implementa, que deve cumprir as garantias sobre a saída. \pause

Vimos também que uma função é **total** quando produz uma resposta válida para todos os valores dos tipos das entradas, e **parcial** quando existem valores para os quais ela não tem uma resposta válida. \pause São esses valores que as restrições do contrato excluem. \pause

No capítulo **Tipos de dados** vimos como definir tipos de dados que são adequados. \pause

Neste capítulo vamos usar os tipos de dados para transformar funções parciais em **funções totais**.


## Como tornar uma função total

Como transformar uma função parcial em uma função total? \pause

- **Ajustar o contrato** (especificação) para adicionar respostas às entradas hoje inválidas, sem mudar os tipos; \pause

- **Expandir** o tipo da saída, para que a função possa responder a todas as entradas; \pause

- **Restringir** o tipo da entrada, para que as entradas inválidas deixem de existir. \pause

Vamos começar com a primeira.


## Ajustar o contrato

Qual deve ser a resposta para `string.slice("casa", 1, 10)`{.gleam}? \pause Depende do contrato! \pause Se o contrato diz que o intervalo da substring deve estar todo contido na string de entrada, então o exemplo é uma violação do contrato e a resposta não fica especificada. \pause

No entanto, se mudarmos o contrato para dizer que a resposta é a parte do intervalo que está contida na string, então a resposta está bem definida e seria `"asa"`{.gleam}. \pause

Qual deve ser a resposta para `10 / 0`{.gleam}? \pause Depende do contrato! \pause Em Gleam a resposta especificada pelo contrato é `0`{.gleam}. \pause

Dessa forma, `string.slice`{.gleam} e `/`{.gleam} foram feitas totais pelo ajuste do contrato. \pause

Mas existe diferença entre os dois casos.


## Ajustar o contrato

Em `string.slice`{.gleam} o ajuste do contrato parece razoável, mas para `/`{.gleam} o ajuste é questionável, afinal, a maioria de nós esperaria que divisão por zero fosse uma quebra de contrato. \pause

Em outras palavras, o "erro", que antes estava explícito na especificação, pode passar disfarçado de resposta no programa. \pause

Então, poderíamos argumentar que o ajuste do contrato é mais adequado quando as novas respostas **generalizam o propósito**, e pode ser uma armadilha quando elas apenas "preenchem um buraco". \pause

Como então poderíamos fazer a função total no caso da divisão? \pause Expandir o tipo da saída para representar a existência ou não de um valor.



Valores opcionais
=================


## Valores opcionais

<div class="columns">
<div class="column" width="54%">
\footnotesize

```gleam
/// Divide *a* por *b*.
pub fn divide(a: Int, b: Int) -> Int {
  case b {
    0 -> todo
    _ -> a / b
  }
}
```

\pause

</div>
<div class="column" width="42%">
Como representar um inteiro que pode ou não estar presente? \pause

São dois casos distintos: ou existe um valor, ou não existe valor algum. \pause Então, podemos criar uma união. \pause

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
<div class="column" width="48%">
\footnotesize

```gleam
/// Produz a divisão de *a* por *b*,
/// ou Nenhum se *b* é zero.
pub fn divide(a: Int, b: Int) -> Opcional {
  case b {
    0 -> Nenhum
    _ -> Algum(a / b)
  }
}
```

```gleam-repl
> divide(10, 3)
Algum(3)
> divide(10, 0)
Nenhum
```

\pause

</div>
<div class="column" width="48%">

\small

Quais as vantagens dessa abordagem? \pause

Trocamos a responsabilidade de passar um divisor diferente de `0`{.gleam}, que estava escrita no contrato, pela responsabilidade de tratar a resposta para o divisor `0`{.gleam}, que está na assinatura da função. \pause

Quem impõe a responsabilidade é o compilador! \pause Com `divide`{.gleam} que devolve `Int`{.gleam}, `1 + divide(10, 0)`{.gleam} compila e vale `1`{.gleam}. Com `Opcional`{.gleam} erro de compilação:

\footnotesize

```

The + operator expects arguments of
this type:
    Int
But this argument has this type:
    Opcional
```

</div>
</div>


## Soma um

\small

Como somar 1 a um valor opcional? \pause Precisamos fazer um `case`{.gleam} com dois casos: \pause

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

\pause

</div>
</div>

\small

E se precisássemos fazer outra operação com o resultado? \pause Precisaríamos de outro `case`{.gleam}! \pause Ou seja, um valor `Opcional`{.gleam} se propaga por toda a cadeia de operações. Por enquanto, vamos fazer uso do `case`{.gleam} para lidar com isso, mas no capítulo de **Funções como valores** veremos como deixar isso mais simples.


## Primeiro caractere

Vamos retomar a `primeiro`{.gleam}, que no capítulo **Projeto de funções** vimos ser parcial.

\pause

<div class="columns">
<div class="column" width="48%">
\small

Outro `Opcional`{.gleam}, agora com `String`{.gleam}. \pause

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

Este é o mesmo problema do preço...
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

Em Python ou Java, a falha costuma ser sinalizada com uma exceção, que desvia o fluxo do programa em vez de produzir uma resposta. \pause

Em uma linguagem pura, sem efeitos colaterais, a falha precisa fazer parte da resposta. \pause

Uma função que pode falhar é uma função parcial, então vamos proceder da mesma forma e transformá-la em uma função total expandindo o tipo da saída.


## Erros

Uma possibilidade é utilizar `Option`{.gleam} como resultado, sendo que `None`{.gleam} representa que a função falhou, e `Some(val)`{.gleam} que a função executou corretamente e produziu `val`{.gleam} como resposta. \pause

Em que situações o tipo `Option`{.gleam} não seria adequado? \pause Quando existe mais de uma possível causa para a falha da função e queremos distinguir entre essas falhas. \pause

Por exemplo, uma função para escrever em um arquivo pode falhar porque o arquivo não existe, o usuário não tem permissão para escrever no arquivo, o disco está cheio, etc. \pause

Como podemos proceder nesse caso?


## Erros

Definimos uma união com duas variantes, cada uma com um valor associado: uma para sucesso e outra para erro. \pause

Em Gleam, este é o tipo `Result`{.gleam}, pré-definido como:

\small

```gleam
pub type Result(ok, error) {
  Ok(ok)
  Error(error)
}
```

\pause

\normalsize

O `Result`{.gleam} tem dois parâmetros de tipo, o `ok`{.gleam}, do valor produzido em caso de sucesso, e o `error`{.gleam}, do valor associado ao erro. \pause

Repare que `ok`{.gleam} e `error`{.gleam}, em minúsculo, são os parâmetros, e `Ok`{.gleam} e `Error`{.gleam}, em maiúsculo, são as variantes.


## Option vs Result

Quando usar cada um? \pause O `Option`{.gleam} representa um valor que pode estar ausente, e o `Result`{.gleam}, uma operação que pode falhar. \pause

Em Gleam, toda função que pode falhar devolve `Result`{.gleam}, mesmo quando não há nada a dizer sobre a falha. \pause Nesses casos o erro é `Nil`{.gleam}, um tipo que tem um único valor, também escrito `Nil`{.gleam}. \pause

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

A `int.divide`{.gleam}, que apareceu no capítulo **Fundamentos**, é a nossa `divide`{.gleam} com `Result(Int, Nil)`{.gleam} no lugar de `Option(Int)`{.gleam}.

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
      Error(Nil) -> Error(Nil)
    }
    Error(Nil) -> Error(Nil)
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


## Erro com mais informação

E se quisermos saber qual das duas strings é inválida? \pause Definimos uma enumeração para os erros e a usamos no lugar do `Nil`{.gleam}. \pause

<div class="columns">
<div class="column" width="48%">
\footnotesize

```gleam
pub type ErroSoma {
  Primeiro
  Segundo
  Ambos
}
```

```gleam
pub fn soma_examples() {
  check.eq(soma("31", "4"), Ok("35"))
  check.eq(soma("a", "4"), Error(Primeiro))
  check.eq(soma("31", "a"), Error(Segundo))
  check.eq(soma("a", "b"), Error(Ambos))
}
```

</div>
<div class="column" width="48%">
\footnotesize

\pause

```gleam
pub fn soma(a, b) -> Result(String, ErroSoma) {
  case int.parse(a), int.parse(b) {
    Ok(a), Ok(b) -> Ok(int.to_string(a + b))
    Error(Nil), Ok(_) -> Error(Primeiro)
    Ok(_), Error(Nil) -> Error(Segundo)
    Error(Nil), Error(Nil) -> Error(Ambos)
  }
}
```

</div>
</div>


Validação
=========


## Validação

No capítulo **Tipos de dados** o `Preco`{.gleam} ficou em aberto, porque faltava uma ferramenta. \pause

Como podemos utilizar o tipo `Result`{.gleam} para lidar com a questão do preço, que deve ser positivo? \pause

A opção mais direta é validar o preço na função `seleciona_combustivel`{.gleam} e devolver `Error`{.gleam} se um dos preços não for positivo.


## Validação

<div class="columns">
<div class="column" width="48%">
\footnotesize

```gleam
/// O preço do litro do combustível.
/// Requer que seja um número positivo.
pub type Preco = Float

pub fn seleciona_combustivel(
  preco_alcool: Preco,
  preco_gasolina: Preco,
) -> Result(Combustivel, Nil) {
  case preco_alcool <=. 0.0 ||
       preco_gasolina <=. 0.0 {
    True -> Error(Nil)
    False -> todo
  }
}
```

\pause

</div>
<div class="column" width="48%">

Qual é a limitação dessa abordagem? \pause

Em todos os lugares em que `Preco`{.gleam} é utilizado, precisamos fazer a validação. \pause

Podemos melhorar? \pause Sim!

</div>
</div>


## Validação

A ideia é definir um Tipo Abstrato de Dado (TAD), esconder o construtor do tipo e deixar no lugar dele uma **função construtora**, que faz a validação. \pause Em outras palavras, estamos restringindo os valores de entrada àqueles que são válidos. \pause

Usamos a palavra-chave `opaque`{.gleam} para criar um TAD em Gleam. \pause

Apenas o módulo que define um tipo `opaque`{.gleam} tem acesso aos seus construtores e campos.


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

\small

Agora a `seleciona_combustivel`{.gleam} é total: todo valor do tipo `Preco`{.gleam} é um preço válido.

</div>
</div>


## Validação

<div class="columns">
<div class="column" width="50%">
\footnotesize

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

\pause

</div>
<div class="column" width="46%">

\small

Como o `preco`{.gleam} devolve `Result`{.gleam}, precisamos extrair o `Preco`{.gleam} antes de chamar a `seleciona_combustivel`{.gleam}. \pause

O `let assert`{.gleam} faz isso, mas interrompe o programa se o valor não casa com o padrão. \pause

\footnotesize

```gleam-repl
> let assert Ok(alcool) = preco(-4.2)
```

```
Error at <repl>:1
  Pattern match failed, no
  pattern matched the value.
  value: Error(Nil)
```

\pause

\small

O que é razoável para testes com constantes.

</div>
</div>


## Expansão vs restrição

E o `Some("")`{.gleam} que a `primeiro`{.gleam} podia devolver? \pause

A saída é a mesma do preço, um tipo opaco cuja função construtora só aceita uma string de um caractere. \pause

Repare que o problema nunca esteve no `Option`{.gleam}, e sim no tipo do conteúdo. \pause

Essa é a ideia por trás da expressão *parse, don't validate*, projete as funções sobre a representação de dados que você gostaria de ter, e não sobre a que você recebeu.


## Expansão vs restrição

Tanto a expansão do tipo da saída quanto a restrição dos tipos de entrada são estratégias válidas para transformar funções parciais em funções totais. \pause

A expansão permite que quem chama a função use qualquer valor da entrada, mas passa a responsabilidade adiante, porque a saída expandida precisa ser tratada. \pause

A restrição empurra a responsabilidade para trás, para quem constrói o dado, e em troca deixa a saída limpa e pronta para usar. \pause

A restrição cabe quando a condição é uma propriedade do próprio dado, que vale em todos os lugares em que ele aparece, como o preço ser positivo. \pause A expansão cabe quando a condição é específica de uma função, como o divisor não ser zero. \pause

Não existe almoço grátis!


Revisão
=======


## Revisão

Quais são as três maneiras de transformar uma função parcial em uma função total? \pause

- Ajustar o contrato, expandir o tipo da saída e restringir o tipo da entrada. \pause

Quando ajustar o contrato é uma boa ideia? \pause

- Quando a nova resposta generaliza o propósito da função, como em `string.slice`{.gleam}. Quando ela apenas preenche um buraco, como o `0`{.gleam} da divisão por zero, o erro fica escondido e é melhor expandir o tipo da saída.


## Revisão

Como representar um valor que pode estar ausente? \pause

- Com o tipo `Option`{.gleam}, que tem as variantes `None`{.gleam} e `Some(a)`{.gleam}. \pause

Como representar o resultado de uma função que pode falhar? \pause

- Com o tipo `Result`{.gleam}, que tem as variantes `Ok(ok)`{.gleam} e `Error(error)`{.gleam}. Em Gleam, toda função que pode falhar devolve `Result`{.gleam}. \pause

O que significa o `a`{.gleam} em `Option(a)`{.gleam}? \pause

- É um parâmetro de tipo, escrito em minúsculo, que pode ser instanciado com qualquer tipo: `Option(Int)`{.gleam}, `Option(String)`{.gleam}, ... É o que evita ter que definir um `Opcional`{.gleam} para cada tipo de conteúdo.


## Revisão

Como garantir que só é possível criar valores válidos de um tipo? \pause

- Definindo um tipo opaco e fazendo a validação na função construtora, que devolve `Result`{.gleam}. \pause

Tornar uma função total elimina o contrato? \pause

- Não. As restrições continuam existindo, mas em vez de ficarem escritas na documentação, elas passam para os tipos, e quem cobra é o compilador. \pause

Quando expandir o tipo da saída e quando restringir o tipo da entrada? \pause

- A restrição, quando a condição é uma propriedade do dado e vale em todo lugar em que ele aparece, como o preço ser positivo. A expansão, quando a condição é específica de uma função, como o divisor não ser zero.


Referências
===========

## Referências

Básicas

- [Tipos opacos em Gleam](https://tour.gleam.run/everything/#advanced-features-opaque-types)

- [Módulo option](https://hexdocs.pm/gleam_stdlib/gleam/option.html) da biblioteca padrão

- [Módulo result](https://hexdocs.pm/gleam_stdlib/gleam/result.html) da biblioteca padrão

Complementares

- [Parse, don't validate](https://lexi-lambda.github.io/blog/2019/11/05/parse-don-t-validate/)
