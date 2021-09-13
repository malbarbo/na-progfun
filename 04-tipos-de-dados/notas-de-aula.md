---
# vim: set spell spelllang=pt_br sw=4:
# TODO: falar da simplificação de cond aninhados
# TODO: falar mais sobre tipos algébricos
# TODO: falar do princípio: “Make Invalid States Unrepresentable”
# TODO: falar do "expression problem"
title: Tipos de dados
---

Introdução
==========


## Introdução

Os tipos de dados que vimos até agora são atômicos, isto é, não podem ser decompostos. \pause

Estamos interessados em representar dados onde dois ou mais valores devem ficar juntos: \pause

- Registro de um aluno;

- Placar de um jogo de futebol;

- Informações de um produto. \pause

Chamamos estes tipos de dados de **estruturas**.


## Estruturas

Em Racket utilizamos a forma especial `struct`{.scheme} para definir estruturas.

\pause

Vamos definir uma estrutura para representar um ponto em um plano cartesiano.


## Estruturas

\small

```scheme
(struct ponto (x y))
(define p1 (ponto 3 4))
(define p2 (ponto 8 2))
> (ponto-x p1)
3
> (ponto-y p1)
4
> (ponto-x p2)
8
> (ponto-y p2)
2
> (ponto? p1)
#t
> (ponto? "ola")
#f
```


## Sintaxe de `struct`{.scheme}

Uma aproximação da sintaxe do `struct`{.scheme} é

```scheme
(struct <id-estrutura> (<id-campo-1> ...))
```


## Funções definidas na criação de uma estrutura

Funções definidas pelo `struct`{.scheme}

```scheme
;; Construtor
id-estrutura

;; Predicado que teste se o valor é do tipo definido
id-estrutura?

;; Seletores
id-estrutura-id-campo
```


## Funções definidas na criação de uma estrutura

A estrutura

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


## Estruturas transparentes

Por padrão, ao exibir um dado estruturado o interpretador não exibe os campos do dado (para preservar o encapsulamento)

```scheme
(struct ponto (x y))
```

```scheme
> (ponto 3 4)
#<ponto>
```


## Estruturas transparentes

Podemos usar a palavra chave `#:transparent`{.scheme} para tornar a estrutura "transparente"

```scheme
(struct ponto (x y) #:transparent)
```

```scheme
; mesmo formato de criação e de exibição
> (ponto 3 4)
(ponto 3 4)
```


## Estruturas transparentes e a função `equal?`

Além de mudar a forma que o ponto é exibido, a palavra chave `#:transparent`{.scheme} também altera o funcionamento da função `equal?`


## Estruturas transparentes e a função `equal?`

```scheme
;; Por padrão, dois pontos são iguais se eles são
;; o mesmo ponto
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
;; campos são iguais
(struct ponto (x y) #:transparent)
(define p1 (ponto 3 4))
(define p2 (ponto 3 4))

> (equal? p1 p2)
#t
> (equal? p1 p1)
#t
```


## Definindo estruturas

Junto com a definição de uma estrutura, também faremos a descrição do propósito e campos da estrutura.


## Definindo estruturas

```scheme
(struct ponto (x y))
;; Ponto representa um ponto no plano cartesiano
;;   x : Número - a coordenada x
;;   y : Número - a coordenada y
```


## Alterando dados estruturados

Se quisermos mudar um campo de um dado estruturado, temos que criar uma cópia com o campo alterado.

Vamos criar um ponto `p2` que é como `p1`, mas com o valor 5 para o campo `y`.

```scheme
> (define p1 (ponto 3 4))
> (define p2 (ponto (ponto-x p1) 5))
> p2
(ponto 3 5)
```


## Alterando dados estruturados

Este método é limitado \pause

- Se a estrutura tem muitos campos e desejamos alterar apenas um campo, temos que especificar a cópia de todos os outros \pause

- Se a estrutura é alterada, todas as operações de "cópia" devem ser alteradas


## Alterando dados estruturados

Racket oferece a forma especial `struct-copy` ([referência](http://docs.racket-lang.org/reference/struct-copy.html)), que facilita este tipo de operação.


## Alterando dados estruturados

```scheme
> (define p2 (struct-copy ponto p1
                                [y 5]))
> p2
(ponto 3 5)
> (define p3 (struct-copy ponto p2
                                [x 4]))
> p3
(ponto 4 5)
> (define p4 (struct-copy ponto p2
                                [y 9]
                                [x 6]))
> p4
(ponto 6 9)
```


## Exemplo: distância

Defina uma função que calcule a distância de um ponto a origem.

## Exemplo: distância

```scheme
;; Ponto -> Número
;; Calcula a distância do ponto p a origem.
(examples
 (check-equal? (distancia-origem (ponto 0 7)) 7)
 (check-equal? (distancia-origem (ponto 1 0)) 1)
 (check-equal? (distancia-origem (ponto 3 4)) 5))

(define (distancia-origem p)
  (sqrt (+ (sqr (ponto-x p))
           (sqr (ponto-y p)))))
```


## Exercício: classificação retângulo

Defina uma estrutura para representar um retângulo. Em seguida defina uma função que classifique um retângulo em largo (largura maior que altura), alto (altura maior que largura) ou quadrado (altura igual a largura).


## Exercício: horas, minutos e segundos

Defina uma função que converta uma quantidade de segundos para uma quantidade de horas, minutos e segundos equivalente. A quantidade de segundos e de minutos da resposta deve ser menor que 60.


## Exercício: conflito

Uma determinada sala de reunião pode ser usada das 8:00h às 18:00h. Cada interessado em utilizar a sala faz uma reserva indicando o intervalo de tempo que gostaria de utilizar a sala. Como parte de um sistema de reservas, você deve projetar uma função que verifique se duas reservas podem ser atendidas, ou seja, não têm conflito de horário.


## Exercício: contagem

Em um sistema de enquete cada possível resposta é identificada por uma cor: verde, vermelho, azul ou branco. Após todos os participantes responderem a enquete, é necessário contabilizar a quantidade de vezes que cada resposta foi selecionada. Como parte desse sistema, você deve projetar uma função que receba a contabilização atual das respostas e uma nova resposta e produza a contabilização atualizada.


## Tipos enumerados

Como representar a classificação de um retângulo em alto, largo ou quadrado? \pause

Como representar uma cor que pode ser verde, vermelho, azul ou branco? \pause

Enumerando os seus valores em um tipo enumerado. \pause

Embora o Racket não suporte a definição de tipos enumerados, podemos registrar em forma de comentários os possíveis valores de um "tipo".

```scheme
;; Cor é um dos valores:
;; - "verde"
;; - "vermelho"
;; - "azul"
;; - "branco"
```


## Problema

Projete uma função que exiba uma mensagem sobre o estado de uma tarefa. Uma tarefa pode estar em execução, ter sido concluída em um tempo específico e com um mensagem de sucesso, ou ter falhado com um código e uma mensagem de erro.

\pause

Como representar o estado de uma tarefa? \pause (Segunda etapa do processo de projeto de funções - Definição dos tipos de dados) \pause

Vamos tentar uma estrutura.


## Problema

\small

```scheme
(struct estado-tarefa (executando tempo msg_sucesso codigo_err msg_err))
;; Representa o estado de uma tarefa
;; executando: Bool - true se a tarefa está em execução, false caso contrário
;; tempo: Número - tempo que durou a execução da tarefa
;; msg_sucesso: String - mensagem caso a tarefa tenha sido executada com sucesso
;; codigo_err: Número - código de erro se a execução da tarefa falhou
;; msg_err: String - mensagem de erro se a execução da tarefa falhou
```

\normalsize

\pause

Qual é o problema dessa representação? \pause

Possíveis estados inválidos. \pause O que significa `(estado-tarefa true 10 "Ótimo desempenho" 123 "Falha na conexão)`? \pause

Como evitar esse problema?


## Uniões

Podemos criar uma união de classes de valores. Veja o vídeo da aula para mais detalhes! \pause

\footnotesize

```scheme
(struct sucesso (tempo msg))
;; Representa o estado de uma tarefa que finalizou a execução com sucesso
;; tempo: Número - tempo de execução em segundos
;; msg  : String - mensagem de sucesso gerada pela tarefa

(struct erro (codigo msg))
;; Representa o estado de uma tarefa que finalizou a execução com falha
;; código: Número - o código da falha
;; msg   : String - mensagem de erro gerada pela tarefa

;; EstadoTarefa é um dos valores:
;; - "Executando"             A tarefa está em execução
;; - (sucesso Número String)  A tarefa finalizou com sucesso
;; - (erro Número String)     A tarefa finalizou com falha
```


## Uniões

Agora podemos ir para a especificação da função. \pause

\small

```scheme
;; EstadoTarefa -> String
;; Produz uma string amigável para o usuário para descrever o estado da tarefa.
(examples
 (check-equal? (msg-usuario "Executando") "A tarefa está em execução.")
 (check-equal? (msg-usuario (sucesso 12 "Os resultados estão corretos"))
               "Tarefa concluída (12s): Os resultados estão corretos.")
 (check-equal? (msg-usuario (erro 123 "Número inválido '12a'"))
               "A tarefa falhou (err 123): Número inválido '12a'."))
(define (msg-usuario estado) "")
```

\pause

Note que o exercício não é muito específico sobre a saída (o foco é no projeto de dados), por isso usamos a criatividade para definir a saída. \pause Note também que como `EstadoTarefa` é definido como a união de três classes de valores, então precisamos de pelo menos um exemplo para cada classe de valores.


## Uniões

Agora vamos para a implementação. \pause

Mesmo sem saber detalhes da implementação, podemos definir uma estrutura do corpo da função baseado apenas no tipo do dado, no caso, `EstatoTarefa`. \pause São três casos, dependendo do caso, podemos usar seletores específicos \pause

\small

```scheme
(define (msg-usuario estado)
  (cond
    [(and (string? estado) (string=? estado "Executando"))
     ...]
    [(sucesso? estado)
     ... (sucesso-tempo estado) ... (sucesso-msg estado)]
    [(erro? estado)
     ... (erro-codigo estado) ... (erro-msg estado)]))
```

\pause

Agora é só preencher as lagunas!


## Uniões

\scriptsize

```scheme
(define (msg-usuario estado)
  (cond
    [(and (string? estado) (string=? estado "Executando"))
     "A tarefa está em execução."]
    [(sucesso? estado)
     (string-append "Tarefa concluída ("
                    (number->string (sucesso-tempo estado))
                    "s): "
                    (sucesso-msg estado)
                    ".")]
    [(erro? estado)
     (string-append
      "A tarefa falhou (err "
      (number->string (erro-codigo estado))
      "): "
      (erro-msg estado)
      ".")]))
```


## Tipos de dados

Vimos duas formas diferentes de definir novos tipos de dados: \pause

- Estruturas: quando diversos valores relacionados são agrupados para representar uma entidade \pause

- Uniões: quando uma entidade é descrita pela união de diversas classes de valores \pause

No contexto de programação funcional, essas construções de tipos são chamadas de tipos de dados algébricos \pause

- As estruturas são chamadas de tipos produto \pause

- As uniões são chamadas de tipos somas \pause

Essa "analogia" com a álgebra é interessante pois nos permite entender mais facilmente alguns aspectos da construção de tipos.


Referências
===========

## Referências

Básicas

- [Vídeos Compound Data](https://www.youtube.com/playlist?list=PL6NenTZG6KrpA-ww35EwcaxY-tgh82TAh)

- [Vídeos Reference](https://www.youtube.com/watch?v=tp44seRHLUQ&list=PL6NenTZG6KrptkOEMyLWDnF0ZjSpVTHAE)

- Seções [5.1](http://docs.racket-lang.org/guide/define-struct.html) do [Guia Racket](http://docs.racket-lang.org/guide/)


Complementares

- Seções [4.1](http://docs.racket-lang.org/reference/structures.html) da [Referência Racket](http://docs.racket-lang.org/reference/)
