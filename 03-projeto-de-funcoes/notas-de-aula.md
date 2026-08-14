---
# vim: set spell spelllang=pt_br sw=4:
title: Projeto de funções
# TODO: substituir Definição de tipos de dados por Projeto de dados? https://course.ccs.neu.edu/cs5010sp15/recipe.html#%28part._data%29
# TODO: melhorar a parte de garantias e restrições
---

## Projeto de funções

Vamos voltar ao problema da Márcia. \pause

Depois que você fez o programa para o Alan, a Márcia, amiga em comum de vocês, soube que você está oferecendo serviços desse tipo e também quer a sua ajuda. O problema da Márcia é que ela sempre tem que fazer a conta manualmente para saber se deve abastecer o carro com álcool ou gasolina. A conta que ela faz é verificar se o preço do álcool é até 70% do preço da gasolina, se sim, ela abastece o carro com álcool, senão ela abastece o carro com gasolina. Você pode ajudar a Márcia também? \pause

Como proceder para projetar este programa?


## Projeto de funções

Vamos usar o mesmo processo de projeto de funções que vocês viram em Fundamentos de Algoritmos. \pause O processo é o mesmo; o que muda é como especificar e implementar usando as técnicas de programação funcional. \pause

Este capítulo é, portanto, uma revisão do processo \pause

- Análise \pause
- Definição dos tipos de dados \pause
- Especificação \pause
- Implementação \pause
- Verificação \pause
- Revisão \pause

Esse processo é inspirado no livro [How to Design Programs](http://htdp.org).


## Objetivos

Cada etapa tem um objetivo e depende das etapas anteriores \pause

- Análise: \pause identificar o problema a ser resolvido \pause
- Definição dos tipos de dados: \pause definir como as informações serão representadas \pause
- Especificação: \pause especificar com precisão o que a função deve fazer \pause
- Implementação: \pause implementar a função de acordo com a especificação \pause
- Verificação: \pause verificar se a implementação está de acordo com a especificação \pause
- Revisão: \pause identificar e fazer melhorias na especificação e implementação \pause

Note que às vezes precisamos alterar a ordem das etapas, por exemplo, podemos estar na implementação e encontrar uma nova condição, e então devemos voltar e alterar a especificação; ou podemos escrever os exemplos antes de terminar o propósito, para entender melhor o problema. \pause

Mas devemos evitar fazer a implementação diretamente!


## Projeto de programas

Mas esse processo serve para projetar funções, como projetamos programas? \pause

Um programa é composto de várias funções, então temos que decompor o programa em funções e aplicar o processo para projetar cada função. \pause

Vamos treinar com problemas simples, de uma função, depois vamos utilizar o processo em problemas mais elaborados.


## Análise

<div class="columns">
<div class="column" width="48%">
Depois que você fez o programa para o Alan, a Márcia, amiga em comum de vocês, soube que você está oferecendo serviços desse tipo e também quer a sua ajuda. O problema da Márcia é que ela sempre tem que fazer a conta manualmente para saber se deve abastecer o carro com álcool ou gasolina. A conta que ela faz é verificar se o preço do álcool é até 70% do preço da gasolina, se sim, ela abastece o carro com álcool, senão ela abastece o carro com gasolina. Você pode ajudar a Márcia também? \pause
</div>
<div class="column" width="48%">
**Análise**

- Quais informações são relevantes e quais podem ser descartadas?
- Existe alguma omissão?
- Existe alguma ambiguidade?
- Quais conhecimentos do domínio do problema são necessários?
- O que deve ser feito?

\pause

**Resultado** \pause

Determinar o combustível que será utilizado. Se o preço do álcool for até 70% do preço da gasolina, então deve-se usar o álcool, senão a gasolina.
</div>
</div>


## Definição dos tipos de dados

<div class="columns">
<div class="column" width="38%">
**Análise**

Determinar o combustível que será utilizado. Se o preço do álcool for até 70% do preço da gasolina, então deve-se usar o álcool, senão a gasolina.

\pause
</div>
<div class="column" width="58%">
**Definição dos tipos de dados** \pause

- Quais são as informações envolvidas no problema? \pause
- Como as informações serão representadas? \pause

**Resultado** \pause

Informações: preço do litro do combustível e o tipo do combustível. \pause Representações: \pause

\footnotesize

```gleam
/// O preço do litro do combustível, deve ser
/// um número positivo.
type Preco =
  Float

/// O tipo do combustível, deve ser "Álcool" ou "Gasolina".
type Combustivel =
  String
```

</div>
</div>


## Apelidos de tipos

A declaração `type Preco = Float`{.gleam} não cria um tipo novo, ela apenas dá um novo nome, um **apelido**, para um tipo que já existe. \pause

Ou seja, `Preco`{.gleam} e `Float`{.gleam} são intercambiáveis, e o compilador não impede que um `Float`{.gleam} qualquer, como um preço negativo, seja usado onde esperamos um `Preco`{.gleam}. \pause

Então por que usar apelidos? \pause Porque o nome diz o que o valor representa e o comentário de documentação registra as restrições que o programa espera, mesmo que o compilador não as verifique.


## Especificação

<div class="columns">
<div class="column" width="48%">
**Análise**

Determinar o combustível que será utilizado. Se o preço do álcool for até 70% do preço da gasolina, então deve-se usar o álcool, senão a gasolina.

**Tipos**

\footnotesize

```gleam
/// O preço do litro do combustível,
/// deve ser um número positivo.
type Preco =
  Float

/// O tipo do combustível,
/// deve ser "Álcool" ou "Gasolina".
type Combustivel =
  String
```

\pause

</div>
<div class="column" width="48%">
**Especificação**

- Assinatura da função
- Propósito (o que a função faz)
- Exemplos de entrada e saída

\pause

**Resultado** \pause

\footnotesize

```gleam
/// Encontra o combustível que deve
/// ser utilizado no abastecimento.
/// Produz "Álcool" se *preco_alcool*
/// for até 70% do *preco_gasolina*,
/// produz "Gasolina" caso contrário.
fn seleciona_combustivel(
  preco_alcool: Preco,
  preco_gasolina: Preco,
) -> Combustivel {
  todo
}
```

</div>
</div>


## Especificação

O `todo`{.gleam} no corpo da função é uma palavra-chave do Gleam que marca uma parte do programa que ainda não foi escrita. \pause

Com ela a função já compila e a assinatura já é verificada, mas o sgleam avisa que o código está incompleto, e o programa termina com erro se a execução chegar no `todo`{.gleam}. \pause

Na especificação usamos o `todo`{.gleam} justamente para deixar explícito que só a especificação está pronta; a implementação vem depois.


## Especificação

Exemplos \pause

\footnotesize

```gleam
pub fn seleciona_combustivel_examples() {
  // 3.00 é maior que 70% de 4.00, que é 2.80
  // -> "Gasolina"
  check.eq(seleciona_combustivel(3.0, 4.0), "Gasolina")
  // 2.90 é menor que 70% de 4.20, que é 2.94
  // -> "Álcool"
  check.eq(seleciona_combustivel(2.9, 4.2), "Álcool")
}
```

\pause

\normalsize

Usamos uma expressão `check.eq(exemplo, esperado)`{.gleam} para especificar cada exemplo e o valor esperado. \pause O sgleam executa automaticamente todos os `check.eq`{.gleam} dentro de todas as funções `pub`{.gleam} terminadas com `_examples`{.gleam} e mostra um resumo dos resultados.

\pause

Falta algum exemplo?


## Especificação

E se o preço do álcool for exatamente 70% do preço da gasolina, como em `seleciona_combustivel(3.5, 5.0)`{.gleam}? \pause Não está claro na especificação o que fazer! \pause

Precisamos tomar uma decisão e modificar o propósito para ficar mais preciso. \pause Quais são as possibilidades? \pause Assumir que exatamente 70% implica no uso do álcool, assumir que implica no uso da gasolina, ou incluir uma terceira resposta, `"Qualquer uma"`{.gleam}. \pause No mundo real quem decide é a Márcia, mas aqui vamos assumir que exatamente 70% implica no uso do álcool. \pause O propósito modificado fica \pause

\footnotesize

```gleam
/// Encontra o combustível que deve ser utilizado no abastecimento. Produz
/// "Álcool" se *preco_alcool* for menor ou igual a 70% do *preco_gasolina*,
/// produz "Gasolina" caso contrário.
fn seleciona_combustivel(preco_alcool: Preco, preco_gasolina: Preco) -> Combustivel {
  todo
}
```


## Especificação

Com a decisão tomada, acrescentamos o exemplo que estava faltando \pause

\footnotesize

```gleam
pub fn seleciona_combustivel_examples() {
  // 3.00 é maior que 70% de 4.00, que é 2.80
  // -> "Gasolina"
  check.eq(seleciona_combustivel(3.0, 4.0), "Gasolina")
  // 2.90 é menor que 70% de 4.20, que é 2.94
  // -> "Álcool"
  check.eq(seleciona_combustivel(2.9, 4.2), "Álcool")
  // 3.50 é exatamente 70% de 5.00
  // -> "Álcool"
  check.eq(seleciona_combustivel(3.5, 5.0), "Álcool")
}
```


## Anotações de tipos

Apesar de as anotações de tipos serem opcionais, de agora em diante vamos **sempre** colocar os tipos das entradas e saídas das funções nomeadas.


## Propósito

No propósito da função descrevemos **o que** a função faz, e não **como** ela faz (que é a implementação — às vezes precisamos dizer como ela faz, mas isso é raro). \pause

No propósito também informamos as garantias da saída e as restrições sobre os parâmetros.


## Diferença de "o que" e "como"

Número par \pause

- O que: verifica se um número é par \pause
- Como: faz o resto da divisão do número por 2 e compara com 0; ou; faz a divisão inteira do número e multiplica por 2 e compara com o número \pause

Ordenação \pause

- O que: ordena os elementos de uma lista em ordem não decrescente \pause
- Como: ordenação por seleção, por inserção, por intercalação, etc


## Especificação

Para saber se a especificação está adequada, faça a seguinte pergunta: \pause

Um outro desenvolvedor, que não tem acesso ao problema original e nem a análise, tem as informações necessárias na especificação para fazer uma implementação e verificação inicial? \pause

Se a resposta for sim, então a especificação está adequada; senão, ela está incompleta.


## Implementação

<div class="columns">
<div class="column" width="46%">

\footnotesize

```gleam
fn seleciona_combustivel(
  preco_alcool: Preco,
  preco_gasolina: Preco,
) -> Combustivel
```

```gleam
check.eq(
  seleciona_combustivel(3.0, 4.0),
  "Gasolina",
)
check.eq(
  seleciona_combustivel(2.9, 4.2),
  "Álcool",
)
check.eq(
  seleciona_combustivel(3.5, 5.0),
  "Álcool",
)
```

\pause

</div>
<div class="column" width="50%">
**Implementação** \pause

- Veremos diversas estratégias de implementação ao longo da disciplina. \pause
- Uma delas é a **direta**. \pause Se a forma de calcular a resposta é sempre a mesma (não depende de uma condição), então escrevemos a expressão da resposta diretamente. \pause
- Outra é a **análise de casos**. \pause Identificamos as formas de resposta e a condição que caracteriza cada uma delas, então escrevemos um caso para cada forma.

</div>
</div>

## Implementação

Temos duas formas de resposta, `"Álcool"`{.gleam} e `"Gasolina"`{.gleam}, portanto, precisamos de uma condição para distinguir quando utilizar cada resposta. \pause No caso, a resposta é `"Álcool"`{.gleam} se `preco_alcool`{.gleam} é menor ou igual a 70% de `preco_gasolina`{.gleam}; e `"Gasolina"`{.gleam} caso contrário. \pause

\footnotesize

```gleam
/// Encontra o combustível que deve ser utilizado no abastecimento. Produz
/// "Álcool" se *preco_alcool* for menor ou igual a 70% do *preco_gasolina*,
/// produz "Gasolina" caso contrário.
fn seleciona_combustivel(preco_alcool: Preco, preco_gasolina: Preco) -> Combustivel {
  case preco_alcool <=. 0.7 *. preco_gasolina {
    True -> "Álcool"
    False -> "Gasolina"
  }
}
```


## Verificação

A implementação está de acordo com a especificação? \pause Vamos executar os exemplos e conferir. \pause

\scriptsize

```gleam
import sgleam/check
/// O preço do litro do combustível, deve ser um número positivo.
type Preco = Float
/// O tipo do combustível, deve ser "Álcool" ou "Gasolina".
type Combustivel = String

fn seleciona_combustivel(preco_alcool: Preco, preco_gasolina: Preco) -> Combustivel {
  case preco_alcool <=. 0.7 *. preco_gasolina {
    True -> "Álcool"
    False -> "Gasolina"
  }
}

pub fn seleciona_combustivel_examples() {
  check.eq(seleciona_combustivel(3.0, 4.0), "Gasolina")
  check.eq(seleciona_combustivel(2.9, 4.2), "Álcool")
  check.eq(seleciona_combustivel(3.5, 5.0), "Álcool")
}
```


## Verificação

Para executarmos os testes, usamos o comando

\footnotesize

No Windows

```console
PS> .\sgleam test arquivo.gleam
```

No Linux ou Mac

```console
$ ./sgleam test arquivo.gleam
```

\pause

A saída será algo como

```
Running tests...
3 tests, 3 success(es), 0 failure(s) and 0 error(s).
```


## Verificação

De forma geral, o fato de uma função produzir a resposta correta para alguns exemplos implica que a função está correta? \pause Não! \pause

Então por que "perder tempo" fazendo os exemplos? \pause O primeiro objetivo dos exemplos é ajudar o projetista a entender como a saída pode ser obtida a partir das entradas. \pause O segundo é ilustrar o seu funcionamento para que a especificação fique mais clara. \pause Depois esses exemplos podem ser usados como uma forma inicial de verificação, que mesmo não mostrando que a função funciona corretamente, aumenta a confiança do desenvolvedor de que o código está correto. \pause

Já que os exemplos são uma verificação inicial, então temos que ampliar a verificação? \pause Sim! \pause De que forma? \pause Testes de propriedades, fuzzing, etc. \pause Para esta disciplina, vamos utilizar apenas os exemplos para fazer a verificação.


## Verificação

Por que um exemplo pode falhar? \pause

- O exemplo está errado \pause
- A implementação está errada \pause
- O exemplo e a implementação estão errados


## Revisão

<div class="columns">
<div class="column" width="48%">

\footnotesize

```gleam
/// O preço do litro do combustível,
/// deve ser um número positivo.
type Preco = Float
/// O tipo do combustível,
/// deve ser "Álcool" ou "Gasolina".
type Combustivel = String
fn seleciona_combustivel(
  preco_alcool: Preco,
  preco_gasolina: Preco,
) -> Combustivel {
  case preco_alcool <=.
       0.7 *. preco_gasolina {
    True -> "Álcool"
    False -> "Gasolina"
  }
}
```

</div>
<div class="column" width="48%">

**Revisão**

\pause

- Podemos melhorar a especificação e o código? \pause
- Podemos fazer simplificações eliminando casos especiais (generalizando)? \pause
- Podemos criar abstrações (definição de constantes e funções)? \pause
- Podemos renomear os objetos?

\pause

**Resultado**

Os tipos de dados permitem representar informações inválidas. \pause

Veremos como lidar com essa questão no capítulo **Tipos de dados**.

</div>
</div>

## Continuação da revisão

Os próximos três exemplos completam a revisão do processo de projeto de funções. \pause

Eles não serão discutidos em aula, estude-os em casa, refazendo cada etapa antes de olhar a resposta. \pause

Cada um deles mostra alguma coisa que o exemplo do combustível não mostrou: como lidar com mais de duas formas de resposta, como proceder quando o problema exige conhecimento de outra área, e como refinar o propósito a partir dos exemplos.


## Exemplo - aumento de salário

O governo deu um aumento de salário para os funcionários públicos. O percentual de aumento depende do valor do salário atual. Para funcionários que ganham até R\$ 1200 o aumento é de 10%, para funcionários que ganham entre R\$ 1200 e R\$ 3000 o aumento é de 7%, para funcionários que ganham entre R\$ 3000 e R\$ 8000, o aumento é de 3%, e finalmente, para os funcionários que ganham mais que R\$ 8000 não haverá aumento. Projete uma função para calcular o novo salário de um funcionário qualquer. \pause

Qual é o primeiro passo? \pause

**Análise** \pause

Calcular o novo salário a partir do salário atual. Se o salário for até R\$ 1200, aumento de 10%; se for maior que R\$ 1200 e até R\$ 3000, aumento de 7%; se for maior que R\$ 3000 e até R\$ 8000, aumento de 3%; se for maior que R\$ 8000, sem aumento.


## Exemplo - aumento de salário

Definição de tipos de dados \pause

\footnotesize

```gleam
/// Salário é um valor em reais, deve ser um número positivo.
type Salario = Float
```

\pause

\normalsize

Especificação \pause

\footnotesize

```gleam
/// Calcula o novo salário a partir de *salario_atual*, aplicando o percentual
/// de aumento determinado da seguinte forma
/// - salario_atual <= 1200, aumento de 10%
/// - 1200 < salario_atual <= 3000, aumento de 7%
/// - 3000 < salario_atual <= 8000, aumento de 3%
/// - 8000 < salario_atual, sem aumento
fn novo_salario(salario_atual: Salario) -> Salario {
  todo
}
```


## Exemplo - aumento de salário

\small

Exemplos \pause

\footnotesize

```gleam
pub fn novo_salario_examples() {
  check.eq(novo_salario(1000.0), 1100.0)
}
```

\small

\pause

Falta alguma coisa nesse exemplo específico? \pause Sim! \pause Além do resultado esperado, é interessante fazer um comentário sobre como o resultado foi obtido. \pause Esse comentário irá nos auxiliar na etapa de implementação. \pause

\footnotesize

```gleam
  // salario_atual <= 1200
  // -> 1000.0 *. 1.1
  check.eq(novo_salario(1000.0), 1100.0)
  check.eq(novo_salario(1200.0), 1320.0)
```

\pause

\small

Note que também adicionamos um exemplo para o caso limite.


## Exemplo - aumento de salário

\footnotesize

```gleam
  // 1200 < salario_atual <= 3000
  // -> 2000.0 *. 1.07
  check.eq(novo_salario(2000.0), 2140.0)
  check.eq(novo_salario(3000.0), 3210.0)
```

```gleam
  // 3000 < salario_atual <= 8000
  // -> 5000.0 *. 1.03
  check.eq(novo_salario(5000.0), 5150.0)
  check.eq(novo_salario(8000.0), 8240.0)
```

```gleam
  // 8000 < salario_atual
  // -> 8000.01
  check.eq(novo_salario(8000.01), 8000.01)
```


## Exemplo - aumento de salário

Implementação \pause

Quantas formas distintas de produzir o resultado da função identificamos nos exemplos? \pause Quatro formas (veja os comentários dos exemplos). \pause

Como existe mais de uma forma de resposta, então usamos análise de casos. \pause Quantos casos vamos precisar? \pause Como são quatro formas de resposta, então precisamos de quatro casos, um para cada forma. \pause

Em Gleam, escrevemos os quatro casos com `case`{.gleam} aninhados: o primeiro separa a primeira forma das demais, o segundo separa a segunda das restantes, e assim por diante.


## Exemplo - aumento de salário

Com essas informações já conseguimos esboçar o corpo da função \pause

\footnotesize

```gleam
fn novo_salario(salario_atual: Salario) -> Salario {
  case condicao1 {
    True -> resposta1
    False ->
      case condicao2 {
        True -> resposta2
        False ->
          case condicao3 {
            True -> resposta3
            False -> resposta4
          }
      }
  }
}
```


## Exemplo - aumento de salário

Agora olhamos para os exemplos, identificamos as condições que caracterizam cada caso, e fazemos a implementação. \pause Qual a condição que caracteriza o primeiro caso? \pause `salario_atual <=. 1200.0`{.gleam} \pause E qual é a forma da resposta para esse caso? \pause `salario_atual *. 1.1`{.gleam} \pause Com isso já podemos preencher o primeiro caso \pause

\scriptsize

```gleam
fn novo_salario(salario_atual: Salario) -> Salario {
  case salario_atual <=. 1200.0 {
    True -> salario_atual *. 1.1
    False ->
      case condicao2 {
        True -> resposta2
        False ->
          case condicao3 {
            True -> resposta3
            False -> resposta4
          }
      }
  }
}
```


## Exemplo - aumento de salário

Repetindo esse processo para os demais casos chegamos na seguinte implementação \pause

\scriptsize

```gleam
fn novo_salario(salario_atual: Salario) -> Salario {
  case salario_atual <=. 1200.0 {
    True -> salario_atual *. 1.1
    False ->
      case salario_atual <=. 3000.0 {
        True -> salario_atual *. 1.07
        False ->
          case salario_atual <=. 8000.0 {
            True -> salario_atual *. 1.03
            False -> salario_atual
          }
      }
  }
}
```

\normalsize

\pause

Note que as condições dos casos seguintes não repetem o que já foi descartado: se chegamos no segundo `case`{.gleam}, já sabemos que o salário é maior que 1200.


## Exemplo - aumento de salário

Verificação \pause

\small

```
Running tests...
7 tests, 7 success(es), 0 failure(s) and 0 error(s).
```

\pause

Revisão \pause

O que podemos melhorar? \pause

- Adicionar comentários sobre os números "mágicos"


## Exemplo - aumento de salário

\scriptsize

```gleam
fn novo_salario(salario_atual: Salario) -> Salario {
  case salario_atual <=. 1200.0 {
    // 10% de aumento
    True -> salario_atual *. 1.1
    False ->
      case salario_atual <=. 3000.0 {
        // 7% de aumento
        True -> salario_atual *. 1.07
        False ->
          case salario_atual <=. 8000.0 {
            // 3% de aumento
            True -> salario_atual *. 1.03
            // sem aumento
            False -> salario_atual
          }
      }
  }
}
```

\normalsize

\pause

Não podemos esquecer de fazer a verificação novamente!


## Exemplo - massa tubo de ferro

O Jorge precisa determinar a massa de diversos pequenos tubos de ferro mas está sem uma balança. No entanto, ele possui um paquímetro e pode medir com precisão o diâmetro interno e externo e a altura dos tubos, agora ele só precisa de um programa para fazer os cálculos. Algum voluntário? \pause

Alguma coisa parece complicada nesse exercício?


## Exemplo - massa tubo de ferro

Nesse exercício precisamos de conhecimento de um domínio (área), que talvez ainda não tenhamos, isso pode fazer o problema parecer mais difícil do que realmente é. \pause Mas então, como proceder nesses casos? \pause

Precisamos de uma pessoa (ou livros) que possam nos instruir sobre o conhecimento do domínio, geralmente os interessados no software podem indicar tais pessoas. \pause

O importante é entender que os desenvolvedores de softwares geralmente resolvem problemas de outras pessoas, e esses problemas podem envolver conhecimentos que não temos e por isso precisamos estar dispostos a estudar e aprender o conhecimento de outras áreas. \pause

Vamos resolver esse problema? Por onde começamos?


## Exemplo - massa tubo de ferro

Análise \pause

- Calcular a massa de um tubo de ferro a partir das suas dimensões. \pause Como as dimensões de um tubo de ferro estão relacionadas com a massa do tubo? \pause

- Dimensões $\rightarrow$ Volume $\rightarrow$ Massa \pause

- Como determinamos o volume de um tubo de ferro a partir das suas dimensões? \pause

    $$volume = \pi \times \left ( raio\_externo^2 - raio\_interno^2 \right ) \times altura$$

    onde $raio\_externo = \frac{diametro\_externo}{2}$ e $raio\_interno = \frac{diametro\_interno}{2}$ \pause

- Como obtemos a massa a partir do volume? \pause A massa é dada por $volume \times densidade$. \pause

- Qual a densidade do ferro? \pause A densidade do ferro é 7874 $kg/m^3$.


## Exemplo - massa tubo de ferro

\small

Definição de tipos de dados \pause

\footnotesize

```gleam
/// Comprimento é um número positivo dado em metros.
type Comprimento = Float
/// Massa é um número positivo dado em quilogramas.
type Massa = Float
```

\small

\pause

Especificação \pause

\footnotesize

```gleam
/// Calcula a massa de um tubo de ferro a partir das suas dimensões.
/// Requer que *diametro_externo* seja maior que *diametro_interno*.
fn massa_tubo_ferro(
  diametro_externo: Comprimento,
  diametro_interno: Comprimento,
  altura: Comprimento,
) -> Massa {
  todo
}
```


## Exemplo - massa tubo de ferro

Exemplos \pause

\footnotesize

```gleam
pub fn massa_tubo_ferro_examples() {
  // -> 3.14 *. { 0.025 *. 0.025 -. 0.015 *. 0.015 } *. 0.1 *. 7874.0
  check.eq(massa_tubo_ferro(0.05, 0.03, 0.1), 0.9889744)
}
```


## Exemplo - massa tubo de ferro

Implementação \pause

Precisamos utilizar análise de casos na implementação? \pause Não! \pause Por quê? \pause Porque só existe uma forma de resposta, ou seja, a resposta é sempre calculada com a mesma expressão. \pause Essa é a implementação **direta**. \pause E é por isso também que um único exemplo já foi suficiente. \pause

E que expressão é essa? \pause A que identificamos na análise do problema e utilizamos para calcular a resposta do exemplo.


## Exemplo - massa tubo de ferro

\scriptsize

```gleam
fn massa_tubo_ferro(
  diametro_externo: Comprimento,
  diametro_interno: Comprimento,
  altura: Comprimento,
) -> Massa {
  let raio_externo = diametro_externo /. 2.0
  let raio_interno = diametro_interno /. 2.0
  3.14
  *. { raio_externo *. raio_externo -. raio_interno *. raio_interno }
  *. altura
  *. 7874.0
}
```


## Exemplo - massa tubo de ferro

Verificação \pause

A verificação falha! \pause

\footnotesize

```
Failure at massa_tubo_ferro.gleam (massa_tubo_ferro_examples:29)
  Actual  : 0.9889744000000004
  Expected: 0.9889744
```

\normalsize

\pause

Comparação de igualdade de números de ponto flutuante quase nunca dá certo! \pause Nesses casos usamos `check.approx`{.gleam}, que permite especificar uma margem de erro. \pause

\footnotesize

```gleam
pub fn massa_tubo_ferro_examples() {
  check.approx(massa_tubo_ferro(0.05, 0.03, 0.1), 0.9889744, 0.00000001)
}
```


## Exemplo - massa tubo de ferro

Revisão \pause

O que podemos melhorar? \pause

- Definir constantes para os números "mágicos" \pause

- Separar o cálculo do volume em etapas, criando uma função para a área do círculo


## Exemplo - massa tubo de ferro

\scriptsize

```gleam
// Na prática precisamos de mais casas decimais!
const pi: Float = 3.14
// Densidade do ferro, em kg/m^3.
const densidade_ferro: Float = 7874.0

fn area_circulo(raio: Comprimento) -> Float {
  pi *. raio *. raio
}

fn massa_tubo_ferro(
  diametro_externo: Comprimento,
  diametro_interno: Comprimento,
  altura: Comprimento,
) -> Massa {
  let area_externa = area_circulo(diametro_externo /. 2.0)
  let area_interna = area_circulo(diametro_interno /. 2.0)
  let volume = { area_externa -. area_interna } *. altura
  volume *. densidade_ferro
}
```


## Exemplo - ajuste de texto

Em um determinado programa é preciso exibir textos em uma quantidade máxima de espaço (número de caracteres). Se o texto não cabe no espaço, apenas a parte inicial do texto que cabe no espaço junto de três pontos deve ser exibida. Além disso, o texto pode ser alinhado a direita, a esquerda ou centralizado. Projete uma função que transforme um texto para que possa ser exibido no espaço desejado.


## Exemplo - ajuste de texto

Análise \pause

Ajustar um texto a um tamanho específico, usando "...", se necessário, para sinalizar que o texto foi abreviado, e alinhar o texto a direita, a esquerda ou no centro.

\pause

Definição de tipos de dados \pause

\small

```gleam
/// Alinhamento é um dos valores "direita", "esquerda" ou "centro".
type Alinhamento = String
```


## Exemplo - ajuste de texto

Especificação \pause

\footnotesize

```gleam
/// Produz uma nova string a partir de *s* que tem exatamente *num_chars*
/// caracteres e é alinhada de acordo com o *alinhamento*.
fn ajusta_string(s: String, num_chars: Int, alinhamento: Alinhamento) -> String {
  todo
}
```

\normalsize

\pause

Essa especificação é precisa o bastante para fazermos uma implementação ou para usarmos essa função? \pause Não.


## Exemplo - ajuste de texto

\scriptsize

```gleam
pub fn ajusta_string_examples() {
  check.eq(ajusta_string("casa", 4, "direita"), "casa")
  check.eq(ajusta_string("casa", 4, "esquerda"), "casa")
  check.eq(ajusta_string("casa", 4, "centro"), "casa")
  check.eq(ajusta_string("casa verde", 7, "direita"), "casa...")
  check.eq(ajusta_string("casa verde", 7, "esquerda"), "casa...")
  check.eq(ajusta_string("casa verde", 7, "centro"), "casa...")
  check.eq(ajusta_string("casa verde", 9, "direita"), "casa v...")
  check.eq(ajusta_string("casa", 9, "direita"), "     casa")
  check.eq(ajusta_string("casa", 9, "esquerda"), "casa     ")
  check.eq(ajusta_string("casa", 9, "centro"), "  casa   ")
  check.eq(ajusta_string("casa", 10, "centro"), "   casa   ")
}
```


## Exemplo - ajuste de texto

O que está faltando nos exemplos? \pause

A forma como as saídas foram computadas e as respectivas condições! \pause

Lembrem-se, o objetivo inicial dos exemplos é ajudar o projetista a entender como a função deve funcionar.


## Exemplo - ajuste de texto

\scriptsize

```gleam
  // string.length(s) == num_chars
  // -> s
  check.eq(ajusta_string("casa", 4, "direita"), "casa")
  check.eq(ajusta_string("casa", 4, "esquerda"), "casa")
  check.eq(ajusta_string("casa", 4, "centro"), "casa")
```

\pause

```gleam
  // string.length(s) > num_chars
  // -> string.slice("casa verde", 0, 7 - 3) <> "..."
  check.eq(ajusta_string("casa verde", 7, "direita"), "casa...")
  check.eq(ajusta_string("casa verde", 7, "esquerda"), "casa...")
  check.eq(ajusta_string("casa verde", 7, "centro"), "casa...")
  check.eq(ajusta_string("casa verde", 9, "direita"), "casa v...")
```


## Exemplo - ajuste de texto

\scriptsize

```gleam
  // string.length(s) < num_chars && alinhamento == "direita"
  // -> string.repeat(" ", 9 - string.length("casa")) <> "casa"
  check.eq(ajusta_string("casa", 9, "direita"), "     casa")
```

\pause

```gleam
  // string.length(s) < num_chars && alinhamento == "esquerda"
  // -> "casa" <> string.repeat(" ", 9 - string.length("casa"))
  check.eq(ajusta_string("casa", 9, "esquerda"), "casa     ")
```


## Exemplo - ajuste de texto

\scriptsize

```gleam
  // string.length(s) < num_chars && alinhamento == "centro"
  // -> string.repeat(" ", num_espacos_inicio)
  //    <> "casa"
  //    <> string.repeat(" ", num_espacos_fim)
  // onde
  //   num_espacos_inicio é { 9 - string.length("casa") } / 2
  //   num_espacos_fim é 9 - string.length("casa") - num_espacos_inicio
  check.eq(ajusta_string("casa", 9, "centro"), "  casa   ")
  check.eq(ajusta_string("casa", 10, "centro"), "   casa   ")
```


## Exemplo - ajuste de texto

Detalhamento do propósito da função a partir do aprimoramento do nosso entendimento obtido com os exemplos.

\scriptsize

```gleam
/// Produz uma nova string a partir de *s* que tem exatamente *num_chars*
/// caracteres e é alinhada de acordo com o *alinhamento*.
///
/// Se *s* tem exatamente *num_chars* caracteres, então produz *s*.
///
/// Se *s* tem mais do que *num_chars* caracteres, então *s* é truncada e "..."
/// é adicionado ao final para sinalizar que a string foi abreviada.
///
/// Se *s* tem menos do que *num_chars* caracteres, então espaços são
/// adicionados no início se *alinhamento* é "direita", no fim se *alinhamento*
/// é "esquerda", ou no início e fim se *alinhamento* é "centro". Nesse último
/// caso, se a quantidade de espaços adicionados for ímpar, então no fim será
/// adicionado 1 espaço a mais do que no início.
```


## {.plain}

\scriptsize

```gleam
fn ajusta_string(s: String, num_chars: Int, alinhamento: Alinhamento) -> String {
  case string.length(s) == num_chars {
    True -> s
    False ->
      case string.length(s) > num_chars {
        True -> string.slice(s, 0, num_chars - 3) <> "..."
        False -> {
          let num_espacos = num_chars - string.length(s)
          case alinhamento {
            "direita" -> string.repeat(" ", num_espacos) <> s
            "esquerda" -> s <> string.repeat(" ", num_espacos)
            _ -> {
              let num_espacos_inicio = num_espacos / 2
              let num_espacos_fim = num_espacos - num_espacos_inicio
              string.repeat(" ", num_espacos_inicio)
              <> s
              <> string.repeat(" ", num_espacos_fim)
            }
          }
        }
      }
  }
}
```


## Exemplo - ajuste de texto

O último caso do `case`{.gleam} sobre o `alinhamento`{.gleam} é `_`{.gleam} e não `"centro"`{.gleam}. \pause

O `_`{.gleam} corresponde a qualquer valor, isto é, esse caso contempla todos os valores que não foram tratados nos casos anteriores. \pause

Ele é necessário porque `Alinhamento`{.gleam} é apenas um apelido de `String`{.gleam}, então além de `"direita"`{.gleam}, `"esquerda"`{.gleam} e `"centro"`{.gleam} existem infinitos outros valores possíveis, e o Gleam exige que todos eles sejam tratados. \pause

Veremos como evitar essa situação no capítulo **Tipos de dados**.


## Exemplo - ajuste de texto

Implementação, versão alternativa \pause

\small

```gleam
/// Produz uma nova string a partir de *s* que tem exatamente *num_chars*
/// caracteres e é alinhada de acordo com o *alinhamento*.
```

\normalsize

\pause

Na especificação podemos notar um "e", indicando que a função faz duas coisas. \pause Então, podemos implementar a função decompondo ela nessas "duas coisas". \pause Supomos que as funções existem e implementamos o corpo \pause

\footnotesize

```gleam
fn ajusta_string(s: String, num_chars: Int, alinhamento: Alinhamento) -> String {
  alinha(limita(s, num_chars), num_chars, alinhamento)
}
```


## Exemplo - ajuste de texto

Agora colocamos essas duas funções em uma **lista de trabalho** (lista de desejos), isto é, a lista de funções que ainda precisam ser projetadas, cada uma com uma especificação inicial, e depois procedemos para implementá-las seguindo as mesmas etapas

\footnotesize

```gleam
/// Produz uma nova string a partir de *s* com no máximo *num_chars*
/// caracteres.
/// ...
fn limita(s: String, num_chars: Int) -> String {
  todo
}

/// Produz uma nova string a partir de *s* alinhada de acordo com o
/// *alinhamento*.
/// ...
fn alinha(s: String, num_chars: Int, alinhamento: Alinhamento) -> String {
  todo
}
```


## Exemplo - ajuste de texto

Verificação (da primeira implementação) \pause

- Ok \pause

Revisão \pause

- Exercício para o leitor!


## Revisão

Quais são as etapas do processo de projeto de funções e o objetivo de cada uma? \pause

- Análise (identificar o problema), definição dos tipos de dados (representar as informações), especificação (dizer com precisão o que a função faz), implementação, verificação (conferir a implementação contra a especificação) e revisão (melhorar o que foi feito). \pause

Por que não devemos ir direto para a implementação? \pause

- Porque cada etapa depende das anteriores: sem a análise não sabemos qual é o problema e sem a especificação não temos como saber se a implementação está certa. \pause

Como sabemos se uma especificação está adequada? \pause

- Se um outro desenvolvedor, sem acesso ao problema original e nem à análise, consegue fazer a implementação e a verificação inicial só com ela. Senão, ela está incompleta.


## Revisão

No propósito de uma função descrevemos o que ela faz ou como ela faz? \pause

- O que ela faz; o como é a implementação. Por exemplo, "verifica se um número é par" é o que, "calcula o resto da divisão por 2 e compara com 0" é o como. No propósito também informamos as garantias da saída e as restrições sobre os parâmetros. \pause

Para que servem os exemplos? Passar em todos eles mostra que a função está correta? \pause

- Não mostra. Eles servem primeiro para o projetista entender como a saída é obtida a partir da entrada, depois para deixar a especificação mais clara e, por fim, como verificação inicial, que aumenta a confiança de que o código está correto sem provar que ele está.


## Revisão

Quais estratégias de implementação vimos e quando usar cada uma? \pause

- A direta, quando existe uma única forma de calcular a resposta, e a análise de casos, quando existe mais de uma, com um caso para cada forma. \pause

Quando um exemplo falha, o que pode estar errado? \pause

- O exemplo, a implementação, ou os dois.


## Referências

Básicas

- Capítulo [3 - How to Design Programs](https://htdp.org/2022-8-7/Book/part_one.html) do
  livro [HTDP](http://htdp.org)

- [Vídeos BSL](https://www.youtube.com/playlist?list=PL6NenTZG6Krqu5RRQi3TUGc605rrGGGWw)

- [Vídeos How to Design Functions](https://www.youtube.com/playlist?list=PL6NenTZG6KroMpbQDFNmv6YuydU1DTklw)
