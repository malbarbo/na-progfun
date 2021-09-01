---
# vim: set spell spelllang=pt_br sw=4:
title: Projeto de Funções
---

## Projeto de funções

Vamos voltar para o problema da Márcia. \pause

Depois que você fez o programa para o Alan, a Márcia, amiga em comum de vocês, soube que você está oferecendo serviços desse tipo e também quer a sua ajuda. O problema da Márcia é que ela sempre tem que fazer a conta manualmente para saber se deve abastecer o carro com álcool ou gasolina. A conta que ela faz é verificar se o preço do álcool é até 70% do preço da gasolina, se sim, ela abastece o carro com álcool, senão ela abastece o carro com gasolina. Você pode ajudar a Márcia também? \pause

Como proceder para projetar este programa?


## Projeto de programas

Para entender e "sentir" melhor como é programar no paradigma funcional, vamos seguir algumas etapas para projetar programas \pause

- Análise \pause
- Definição dos tipos de dados \pause
- Especificação \pause
- Implementação \pause
- Verificação \pause
- Revisão \pause

Vamos treinar com problemas simples, para depois utilizar o processo em outros problemas. \pause

Obs: esse processo é inspirado no livro [How to Design Programs](http://htdp.org).


## Projeto de programas

Cada etapa depende da anterior, mas às vezes pode ser necessário mudar a ordem. \pause

Por exemplo, às vezes estamos na implementação e encontramos uma nova condição e devemos voltar e alterar a especificação. \pause

Mas devemos evitar fazer a implementação diretamente!


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
<div class="column" width="40%">
**Análise**

Determinar o combustível que será utilizado. Se o preço do álcool for até 70% do preço da gasolina, então deve-se usar o álcool, senão a gasolina.

\pause
</div>
<div class="column" width="60%">
**Definição dos tipos de dados** \pause

- Quais são as informações envolvidas no problema? \pause
- Como as informações serão representadas? \pause

**Resultado** \pause

Informações: preço do litro do combustível e o tipo do combustível. \pause

Representações: \pause

\small

```scheme
;; Preco é um número positivo com até três dígitos.

;; Combustivel é um dos valores
;; - "Alcool"
;; - "Gasolina"
```

</div>
</div>


## Definição dos tipos de dados

Mesmo Racket sendo uma linguagem com vinculação dinâmica de tipos e não tendo apelidos de tipos e tipos enumerados, nós descrevemos em comentários os "tipos" que vamos utilizar. \pause Nesse caso, os tipos servem como documentação.


## Especificação

<div class="columns">
<div class="column" width="50%">
**Análise**

Determinar o combustível que será utilizado. Se o preço do álcool for até 70% do preço da gasolina, então deve-se usar o álcool, senão a gasolina.

**Tipos**

```scheme
;; Preco é um número positivo
;; com até três dígitos.

;; Combustivel é um dos valores
;; - "Alcool"
;; - "Gasolina"
```

\pause

</div>
<div class="column" width="50%">
**Especificação**

- Assinatura da função
- Descrição do que a função deve fazer
- Exemplos de entrada e saída

\pause

**Resultado** \pause

\small

```scheme
;; Preco Preco -> Combustivel
;; Encontra o combustivel que deve ser
;; utilizado no abastecimento. Produz
;; "Alcool" se preco-alcool for até 70%
;; do preco-gasolina, produz "Gasolina"
;; caso contrário.
(define (seleciona-combustivel
          preco-alcool
          preco-gasolina) ...)
```

</div>
</div>


## Especificação

Exemplos \pause

- Álcool 3.000, Gasolina 4.000, \pause produz "Gasolina" pois 3.000 > 0.7 * 4.000 \pause
- Álcool 2.900, Gasolina 4.200, \pause produz "Alcool" pois 2.900 < 0.7 * 4.200 \pause
- Álcool 3.500, Gasolina 5.000, \pause não está claro na especificação o que fazer quando o preço do álcool é exatamente 70% (3.500 = 0.7 * 5.000)! \pause

Precisamos tomar uma decisão e modificar o propósito para ficar mais preciso. \pause Vamos assumir que exatamente 70% também implica no uso do álcool (quais são as outras possibilidades?). \pause O propósito modificado fica \pause

\small

```scheme
;; Preco Preco -> Combustivel
;; Encontra o combustivel que deve ser utilizado no abastecimento.
;; Produz "Alcool" se preco-alcool for menor ou igual a 70% do preco-gasolina,
;; produz "Gasolina" caso contrário.
```


## Implementação

<div class="columns">
<div class="column" width="50%">

\small

```scheme
;; Preco Preco -> Combustivel
;; Encontra o combustivel que deve ser
;; utilizado no abastecimento. Produz
;; "Alcool" se preco-alcool for menor ou
;; igual a 70% do preco-gasolina, produz
;; "Gasolina" caso contrário.
(define (seleciona-combustivel
          preco-alcool
          preco-gasolina)
  ...)
```

3.000, 4.000, então "Gasolina" (3.000 > 0.7 * 4.000)

2.900, 4.200, então "Alcool" (2.900 < 0.7 * 4.200)

3.500, 5.000, então "Alcool" (3.500 == 0.7 * 5.000)

\pause

</div>
<div class="column" width="50%">
**Implementação** \pause

- É necessário conhecimento específico do domínio do problema? \pause Então enumere o que será utilizado. \pause
- Existem casos distintos? \pause Então enumere os casos. \pause
- É uma composição de funções? \pause Então use pensamento desejoso e faça a composição das funções supondo que elas existam. \pause
- Os dados de entradas tem autorreferência? \pause Então faça a análise dos casos base e com autorreferência e chame a função recursivamente nos casos apropriados.

</div>
</div>

## Implementação

Temos dois casos, o preço do álcool é menor ou igual a 70% do preço da gasolina e o caso contrário. \pause Cada caso produz uma resposta direta \pause

```scheme
;; Preco Preco -> Combustivel
;; Encontra o combustivel que deve ser utilizado no abastecimento. Produz
;; "Alcool" se preco-alcool for menor ou igual a 70% do preco-gasolina,
;; produz "Gasolina" caso contrário.
(define (seleciona-combustivel preco-alcool preco-gasolina)
  (if (<= preco-alcool (* 0.7 preco-gasolina))
      "Alcool"
      "Gasolina"))
```


## Verificação

<div class="columns">
<div class="column" width="50%">

\small

```scheme
;; Preco Preco -> Combustivel
;; Encontra o combustivel que deve ser
;; utilizado no abastecimento. Produz
;; "Alcool" se preco-alcool menor ou
;; igual a 70% do preco-gasolina, produz
;; "Gasolina" caso contrário.
(define (seleciona-combustivel
         preco-alcool
         preco-gasolina)
  (if (<= preco-alcool
          (* 0.7 preco-gasolina))
      "Alcool"
      "Gasolina"))
```

\vspace{-0.3cm}

3.000, 4.000, então "Gasolina". 2.900, 4.200, então "Alcool". 3.500, 5.000, então "Alcool".

\pause

</div>
<div class="column" width="50%">
**Verificação** \pause

- A implementação está de acordo com a especificação? \pause

**Resultado**

\small

Vamos utilizar os exemplos que criamos na especificação para verificar se a resposta é a esperada. \pause

```scheme
> (seleciona-combustivel 3.000 4.000)
"Gasolina"
```

\vspace{-0.5cm}

\pause

```scheme
> (seleciona-combustivel 2.900 4.200)
"Alcool"
```

\vspace{-0.5cm}

\pause

```scheme
> (seleciona-combustivel 3.500 5.000)
"Alcool"
```

</div>
</div>


## Verificação

Preparem-se, agora vem uma sequência de muitas perguntas! \pause

De forma geral, o fato de uma função produzir a resposta correta para alguns exemplos, implica que a função está correta? \pause Não! \pause

Então porque "perder tempo" fazendo os exemplos? \pause O primeiro objetivo dos exemplos é ajudar o programador a entender como a função funciona e ilustrar o seu funcionamento para que a especificação fique mais clara. \pause Depois esses exemplos podem ser usados como uma forma inicial de verificação, que mesmo não mostrando que a função funciona corretamente, aumenta a confiança do programador que o código está correto. \pause

Já que os exemplos são uma verificação inicial, então temos que ampliar a verificação? \pause Sim. \pause De que forma? \pause Testes de propriedades, fuzzing, etc. \pause Para esta disciplina, vamos utilizar apenas os exemplos para fazer a verificação.


## Verificação

Nós fizemos os exemplos em linguagem natural e no momento de verificar os exemplos nós "traduzimos" para o Racket e fizemos as chamadas da funções de forma manual na janela de interações. \pause Podemos melhorar esse processo? \pause Sim. \pause

Vamos escrever os exemplos diretamente em forma de código de maneira que eles possam ser executados automaticamente quando necessário. Para isso vamos usar um biblioteca, feita especialmente para essa disciplina. \pause

Para instalar a biblioteca selecione o menu "File -> Install Package...", digite o endereço "https://github.com/malbarbo/racket-test-examples.git" e clique em "Install".


## Verificação

\footnotesize

```scheme
#lang racket
(require examples)

;; Preco Preco -> Combustivel
;;
;; Encontra o combustivel que deve ser utilizado no abastecimento.
;; Produz "Alcool" se preco-alcool menor ou igual a 70% do preco-gasolina,
;; produz "Gasolina" caso contrário.
(examples
 (check-equal? (seleciona-combustivel 3.000 4.000) "Gasolina")
 (check-equal? (seleciona-combustivel 2.900 4.200) "Alcool")
 (check-equal? (seleciona-combustivel 3.500 5.000) "Alcool"))

(define (seleciona-combustivel preco-alcool preco-gasolina)
  (if (<= preco-alcool (* 0.7 preco-gasolina))
      "Alcool"
      "Gasolina"))
```


## Verificação

Ao executarmos o programa obtemos algo como

```
3 success(es) 0 failure(s) 0 error(s) 3 test(s) run
```


## Verificação

Porque um teste pode falhar? \pause

- O teste está errado \pause
- A implementação está errada \pause
- O teste e a implementação estão errados


## Revisão

**Revisão**

\pause

- Podemos melhor o código? \pause
- Podemos fazer simplificações eliminando casos especiais (generalizando)? \pause
- Podemos criar abstrações (definição de constantes e funções)? \pause
- Podemos renomear os objetos?


## Exercícios

1. O governo deu uma aumento de salário para os funcionários públicos. O percentual de aumento depende do valor do salário atual. Para funcionários que ganham até R$ 1200 o aumento é de 10%, para funcionários que ganham entre R$ 1200 e R$ 3000 o aumento é de 7%, para funcionários que ganham entre R$ 3000 e R$ 8000, o aumento é de 3%, e finalmente, para os funcionários que ganham mais que R$ 8000 não haverá aumento. Projete uma função para calcular o novo salário de um funcionário qualquer.


## Exercícios

2. O Jorge precisa saber a massa de diversos pequenos tubos de ferro mas está sem uma balança. No entanto, ele possui um paquímetro e pode medir com precisão o diâmetro interno e externo e a altura dos tubos, agora ele só precisa de um programa para fazer os cálculos. Algum voluntário? \pause

Este é um desafio! Tente seguir o processo, procure informações sobre o domínio do problema, se você não conseguir avançar, passe para o próximo problema. \pause

Talvez você tenha problemas com o `check-equal?` e número inexatos... Como você pode contornar esses problemas?


## Exercícios

3. Em um determinado programa é preciso exibir textos em uma quantidade máxima de espaço (número de caracteres). Se o texto não cabe no espaço, apenas a parte inicial do texto que cabe no espaço junto de três pontos deve ser exibida. Além disso, o texto pode ser alinhado a direita, a esquerda ou centralizado. Projete um programa que transforme um texto para que possa ser exibido no espaço desejado.

Veja as funções de manipulação de strings em \url{https://docs.racket-lang.org/reference/strings.html}, particularmente a função [`make-string`](https://docs.racket-lang.org/reference/strings.html#%28def._%28%28quote._~23~25kernel%29._make-string%29%29]).


## Resolução do exercício 1

**Análise** \pause

- Calcular o novo salário a partir do salário atual. Se o salário for $<=$ R$ 1200, aumento de 10%, $>$ R$ 1200 e $<=$ R$ 3000, aumento de 7%, $>$ R$ 3000 e $<=$ R$ 8000, aumento de 3%, $>$ R$ 8000, sem aumento.

\pause

**Definição de tipos de dados** \pause

```scheme
;; Salário é um número positivo com duas casas decimais
```

## Resolução do exercício 1

**Especificação** \pause

```scheme
;; Salario -> Salario

;; Calcula o novo salário a partir de um percetual de aumento determinado
;; a partir de salario-atual da seguinte forma:
;; - salario-atual <= 1200, aumento de 10%
;; - 1200 < salario-atual <= 3000, aumento de 7%
;; - 3000 < salario-atual <= 8000, aumento de 3%
;; - 8000 < salario-atual, sem aumento
(define (novo-salario salario-atual) ...)
```


## Resolução do exercício 1

**Especificação** \pause

```scheme
(examples
 (check-equal? (novo-salario 1000.00) 1100.00)
 (check-equal? (novo-salario 1200.00) 1320.00)
 (check-equal? (novo-salario 2000.00) 2140.00)
 (check-equal? (novo-salario 3000.00) 3210.00)
 (check-equal? (novo-salario 5000.00) 5150.00)
 (check-equal? (novo-salario 8000.00) 8240.00)
 (check-equal? (novo-salario 8000.01) 8000.01))
```


## Resolução do exercício 1

**Implementação** \pause

\small

```scheme
(define (novo-salario salario-atual)
  (cond
    [(<= salario-atual 1200) (* salario-atual 1.1)]
    [(and (< 1200 salario-atual) (<= salario-atual 3000)) (* salario-atual 1.07)]
    [(and (< 3000 salario-atual) (<= salario-atual 8000)) (* salario-atual 1.03)]
    [(> salario-atual 8000) salario-atual]))
```

\pause

**Verificação**

```
7 success(es) 0 failure(s) 0 error(s) 7 test(s) run
```


## Resolução do exercício 1

**Revisão** \pause

\small

```scheme
(define (novo-salario salario-atual)
  (cond
    [(<= salario-atual 1200) (* salario-atual 1.10)] ; 10% de aumento
    [(<= salario-atual 3000) (* salario-atual 1.07)] ; 7% de aumento
    [(<= salario-atual 8000) (* salario-atual 1.03)] ; 3% de aumento
    [else salario-atual]))                           ; sem aumento
```

\pause

Não podemos esquecer de fazer a verificação novamente!


## Resolução do exercício 2

**Análise** \pause

- Calcular a massa de um tubo de ferro a partir das suas dimensões \pause

- Dimensões -> Volume -> Massa \pause

- O volume de um tubo é dado por $\pi ((diametro\_externo - diametro\_interno)/2)^2 \times altura$ \pause

- A massa é dado por $volume \times densidade$ \pause

- A densidade do ferro é 7874 $kg/m^3$ \pause


**Definição de tipos de dados**

```scheme
;; Comprimento é um número positivo dado em metros
;; Massa é um número positivo dado em quilogramas
```


## Resolução do exercício 2

**Especificação**

```scheme
; Comprimento Comprimento Comprimento -> Massa

;; Calcula a massa de um tubo de ferro a partir da suas dimensões
(define (massa-tubo-ferro diametro-externo diametro-interno altura) ...)
```

```scheme
(examples
 (check-equal? (massa-tubo-ferro 0.05 0.03 0.1) 0.2472436))
```


## Resolução do exercício 2

**Implementação** \pause

```scheme
(define (massa-tubo-ferro diametro-externo diametro-interno altura)
  (* 3.14
     (sqr (/ (- diametro-externo diametro-interno) 2))
     altura
     7874)) ; densidade do ferro
```

\pause

**Verificação** \pause

```
FAILURE
name:       check-equal?
location:   exercicios-resolvidos.rkt:48:1
actual:     0.24724360000000015
expected:   0.2472436
```


## Resolução do exercício 2

Comparação de igualdade de números de ponto flutuante quase não dá certo! \pause Nesses casos, usamos `check-=` que permite especificar uma margem de erro. \pause

```scheme
(examples
 (check-= (massa-tubo-ferro 0.05 0.03 0.1) 0.2472436 0.00000001))
```


## Resolução do exercício 2

**Revisão**

\pause

\small

```scheme
(define DENSIDADE-FERRO 7874) ; Em kg/m^2

(define (massa-tubo-ferro diametro-externo diametro-interno altura)
  (define area-da-base (* 3.14 (sqr (/ (- diametro-externo diametro-interno) 2))))
  (define volume (* area-da-base altura))
  (* volume DENSIDADE-FERRO))
```

\pause

Não podemos esquecer de fazer a verificação novamente!


## Resolução do exercício 3

**Análise** \pause

- Limitar um texto a um tamanho máximo (usando ... para sinalizar que o texto foi limitado) e alinhar o texto a direita, esquerda ou centralizado

\pause

**Definição de tipos de dados** \pause

```scheme
;; Alinhamento é um dos valores
;; - "direita"
;; - "esquerda"
;; - "centro"
```


## Resolução do exercício 3

**Especificação** \pause

```scheme
;; String Number Alinhamento -> String
;;
;; Produz uma nova string a partir de s que tem exatamente num-chars
;; caracteres e é alinhada de acordo com o alinhamento.
```

\pause

Essa especificação é precisa o bastante para fazermos uma implementação ou para usarmos essa função? \pause Não.


## Resolução do exercício 3

```scheme
;; Se s tem exatamente num-chars caracteres, então produz s.
;;
;; Se s tem mais do que num-chars caracteres, então s é truncada e ...
;; é adicionado ao final para sinalizar que a string foi abreviada.
;;
;; Se s tem menos do que num-chars caracteres, então espaços são
;; adicionados no início se alinhamento é "esquerda", no fim
;; se alinhamento é "direita", ou no ínicio e fim se alinhamento
;; e "centro". Nesse último caso, se a quantidade de espaços adicionados
;; for impar, então no fim será adicionado 1 espaço a mais do que no início.
```

## Resolução do exercício 3

```scheme
(examples
 (check-equal? (ajusta-string "casa" 4 "direita") "casa")
 (check-equal? (ajusta-string "casa" 4 "esquerda") "casa")
 (check-equal? (ajusta-string "casa" 4 "centro") "casa")
 (check-equal? (ajusta-string "casa verde" 7 "direita") "casa...")
 (check-equal? (ajusta-string "casa verde" 7 "esquarda") "casa...")
 (check-equal? (ajusta-string "casa verde" 7 "centro") "casa...")
 (check-equal? (ajusta-string "casa verde" 9 "direita") "casa v...")
 (check-equal? (ajusta-string "casa" 9 "direita") "     casa")
 (check-equal? (ajusta-string "casa" 9 "esquerda") "casa     ")
 (check-equal? (ajusta-string "casa" 9 "centro") "  casa   ")
 (check-equal? (ajusta-string "casa" 10 "centro") "   casa   "))
```


## {.plain}

\footnotesize

```scheme
(define (ajusta-string s num-chars alinhamento)
  (cond
    [(= (string-length s) num-chars) s]
    [(> (string-length s) num-chars) (string-append (substring s 0 (- num-chars 3)) "...")]
    [else
     (define num-espacos (- num-chars (string-length s)))
     (cond
       [(equal? alinhamento "direita")
        (string-append (make-string num-espacos #\space) s)]
       [(equal? alinhamento "esquerda")
        (string-append s (make-string num-espacos #\space))]
       [else
        (define num-espacos-inicio (quotient num-espacos 2))
        (define num-espacos-fim (- num-espacos num-espacos-inicio))
        (string-append
         (make-string num-espacos-inicio #\space)
         s
         (make-string num-espacos-fim #\space))])]))
```


## Resolução do exercício 3

**Verificação** \pause

- Ok \pause

**Revisão** \pause

- Exercício para o leitor!


## Resolução do exercício 3

**Implementação**, versão alternativa \pause

```scheme
;; String Number Alinhamento -> String
;;
;; Produz uma nova string a partir de s que tem exatamente num-chars
;; caracteres e é alinhada de acordo com o alinhamento.
```

\pause

Na especificação podemos notar um "e", indicando que a função faz duas coisas. \pause Então, podemos implementar a função decompondo ela nessas "duas coisas". \pause Supomos que as funções existem e implementamos o corpo \pause

```scheme
(define (ajusta-string s num-chars alinhamento)
  (alinha (limita s num-chars)
          num-chars
          alinhamento))
```

## Resolução do exercício 3

Agora colocamos essas duas funções em uma lista de trabalho, com um especificação inicial e depois procedemos para implementá-las seguindo as mesmas etapas

```scheme
;; String Number -> Number
;;
;; Produz uma nova string a partir de s com no máximo num-chars.
;; ...
(define (limita s num-chars) ...)

;; String Number Alinhamento -> Number
;;
;; Produz uma nova string a partir de s alinhada de acordo com o alinhamento.
;; ...
(define (alinha s num-chars alinhamento)
```


Referências
===========

## Referências básicas

- [Vídeos BSL](https://www.youtube.com/playlist?list=PL6NenTZG6Krqu5RRQi3TUGc605rrGGGWw)

- [Vídeos How to Design Functions](https://www.youtube.com/playlist?list=PL6NenTZG6KroMpbQDFNmv6YuydU1DTklw)
