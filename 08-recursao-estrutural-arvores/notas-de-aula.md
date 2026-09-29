---
# vim: set spell spelllang=pt_br sw=4:
title: Recursão estrutural
subtitle: Árvores
---


Introdução
==========


## Introdução

Listas e números naturais têm uma única autorreferência na definição, por isso as funções que os processam fazem uma única chamada recursiva. \pause

Neste capítulo, vamos ver tipos em que a autorreferência aparece mais de uma vez (árvores binárias) ou de forma indireta, por meio de outro tipo (árvores em que cada nó tem uma lista de filhos). \pause

A ideia continua a mesma: o modelo de função segue a definição do tipo, e cada autorreferência na definição corresponde a uma chamada recursiva na função.


Árvores binárias
================


## Árvores binárias

Como podemos definir uma árvore binária?

```
        3
      /   \
     4     7
    /     / \
   3     8   9
            /
           10
```


## Árvores binárias {.t}

<div class="columns">
<div class="column" width="56%">

\small

Uma **árvore binária** é \pause

- Vazia; ou \pause

- Um nó contendo um valor e **árvores binárias** à esquerda e à direita.

\pause

\footnotesize

\ \

```gleam
type Arvore(a) {
  Vazia
  No(valor: a, esq: Arvore(a), dir: Arvore(a))
}
```

\pause

</div>
<div class="column" width="42%">

\footnotesize

```
        3
      /   \
     4     7
    /     / \
   3     8   9
            /
           10
```

\pause

```gleam
No(3,
  No(4,
    No(3, Vazia, Vazia)
    Vazia),
  No(7,
    No(8, Vazia, Vazia)
    No(9,
      No(10, Vazia, Vazia)
      Vazia)))
```

</div>
</div>


## Árvores binárias {.t}

<div class="columns">
<div class="column" width="56%">

\small

Uma **árvore binária** é

- Vazia; ou

- Um nó contendo um valor e **árvores binárias** à esquerda e à direita.


\footnotesize

\ \

```gleam
type Arvore(a) {
  Vazia
  No(valor: a, esq: Arvore(a), dir: Arvore(a))
}
```

</div>
<div class="column" width="42%">

Modelo de função para árvores binárias

\footnotesize

```gleam
fn fn_para_ab(r: Arvore(a)) {
  case arv {
    Vazia -> todo
    No(valor, esq, dir) -> {
      todo
      valor
      fn_para_ab(esq)
      fn_para_ab(dir)
    }
  }
}
```

</div>
</div>


## Exemplo: nós folhas

Projete uma função que determine a quantidade de nós-folha em uma árvore.


## Exemplo: nós folhas {.t}

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
/// Determina o número de nós-folha de *r*.
fn num_folhas(r: Arvore(a)) -> Int {
  todo
}

```

\pause

</div>
<div class="column" width="48%">

\scriptsize

```gleam
fn num_folhas_examples() {
  //     t4  3
  //       /   \
  //  t3  4     7  t2
  //     / \   / \
  //    3   2 8   9  t1
  //             /
  //        t0  10
  let t0 = No(10, Vazia, Vazia)
  let t1 = No(9, t0, Vazia)
  let t2 = No(7, No(8, Vazia, Vazia), t1)
  let t3 = No(4, No(3, Vazia, Vazia), No(2, Vazia, Vazia))
  let t4 = No(3, t3, t2)
  check.eq(num_folhas(Vazia), 0)
  check.eq(num_folhas(t0), 1)
  check.eq(num_folhas(t1), 1)
  check.eq(num_folhas(t2), 2)
  check.eq(num_folhas(t3), 2)
  check.eq(num_folhas(t4), 4)
}
```

</div>
</div>


## Exemplo: nós folhas {.t}

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
/// Determina o número de nós-folha de *r*.
fn num_folhas(r: Arvore(a)) -> Int {
  case r {
    Vazia -> todo
    No(valor, esq, dir) -> {
      todo
      valor
      num_folhas(esq)
      num_folhas(dir)
    }
  }
}

```

</div>
<div class="column" width="48%">

\scriptsize

```gleam
fn num_folhas_examples() {
  //     t4  3
  //       /   \
  //  t3  4     7  t2
  //     / \   / \
  //    3   2 8   9  t1
  //             /
  //        t0  10
  let t0 = No(10, Vazia, Vazia)
  let t1 = No(9, t0, Vazia)
  let t2 = No(7, No(8, Vazia, Vazia), t1)
  let t3 = No(4, No(3, Vazia, Vazia), No(2, Vazia, Vazia))
  let t4 = No(3, t3, t2)
  check.eq(num_folhas(Vazia), 0)
  check.eq(num_folhas(t0), 1)
  check.eq(num_folhas(t1), 1)
  check.eq(num_folhas(t2), 2)
  check.eq(num_folhas(t3), 2)
  check.eq(num_folhas(t4), 4)
}
```

</div>
</div>


## Exemplo: nós folhas {.t}

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
/// Determina o número de nós-folha de *r*.
fn num_folhas(r: Arvore(a)) -> Int {
  case r {
    Vazia -> 0
    No(valor, esq, dir) -> {
      todo
      valor
      num_folhas(esq)
      num_folhas(dir)
    }
  }
}

```

</div>
<div class="column" width="48%">

\scriptsize

```gleam
fn num_folhas_examples() {
  //     t4  3
  //       /   \
  //  t3  4     7  t2
  //     / \   / \
  //    3   2 8   9  t1
  //             /
  //        t0  10
  let t0 = No(10, Vazia, Vazia)
  let t1 = No(9, t0, Vazia)
  let t2 = No(7, No(8, Vazia, Vazia), t1)
  let t3 = No(4, No(3, Vazia, Vazia), No(2, Vazia, Vazia))
  let t4 = No(3, t3, t2)
  check.eq(num_folhas(Vazia), 0)
  check.eq(num_folhas(t0), 1)
  check.eq(num_folhas(t1), 1)
  check.eq(num_folhas(t2), 2)
  check.eq(num_folhas(t3), 2)
  check.eq(num_folhas(t4), 4)
}
```

</div>
</div>


## Exemplo: nós folhas {.t}

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
/// Determina o número de nós-folha de *r*.
fn num_folhas(r: Arvore(a)) -> Int {
  case r {
    Vazia -> 0
    No(_, esq, dir) ->
      case esq, dir {
        Vazia, Vazia -> 1
        _, _ ->
          num_folhas(esq) + num_folhas(dir)
      }
  }
}

```

</div>
<div class="column" width="48%">

\scriptsize

```gleam
fn num_folhas_examples() {
  //     t4  3
  //       /   \
  //  t3  4     7  t2
  //     / \   / \
  //    3   2 8   9  t1
  //             /
  //        t0  10
  let t0 = No(10, Vazia, Vazia)
  let t1 = No(9, t0, Vazia)
  let t2 = No(7, No(8, Vazia, Vazia), t1)
  let t3 = No(4, No(3, Vazia, Vazia), No(2, Vazia, Vazia))
  let t4 = No(3, t3, t2)
  check.eq(num_folhas(Vazia), 0)
  check.eq(num_folhas(t0), 1)
  check.eq(num_folhas(t1), 1)
  check.eq(num_folhas(t2), 2)
  check.eq(num_folhas(t3), 2)
  check.eq(num_folhas(t4), 4)
}
```

</div>
</div>


## Exemplo: nós folhas {.t}

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
/// Determina o número de nós-folha de *r*.
fn num_folhas(r: Arvore(a)) -> Int {
  case r {
    Vazia -> 0
    No(_, Vazia, Vazia) -> 1
    No(_, esq, dir) ->
      num_folhas(esq) + num_folhas(dir)
  }
}

```

</div>
<div class="column" width="48%">

\scriptsize

```gleam
fn num_folhas_examples() {
  //     t4  3
  //       /   \
  //  t3  4     7  t2
  //     / \   / \
  //    3   2 8   9  t1
  //             /
  //        t0  10
  let t0 = No(10, Vazia, Vazia)
  let t1 = No(9, t0, Vazia)
  let t2 = No(7, No(8, Vazia, Vazia), t1)
  let t3 = No(4, No(3, Vazia, Vazia), No(2, Vazia, Vazia))
  let t4 = No(3, t3, t2)
  check.eq(num_folhas(Vazia), 0)
  check.eq(num_folhas(t0), 1)
  check.eq(num_folhas(t1), 1)
  check.eq(num_folhas(t2), 2)
  check.eq(num_folhas(t3), 2)
  check.eq(num_folhas(t4), 4)
}
```

</div>
</div>



## Exemplo: altura árvore

Defina uma função que determine a altura de uma árvore binária. A altura de uma árvore binária é a distância entre a raiz e o seu descendente mais afastado. Uma árvore com um único nó tem altura 0.


## Exemplo: altura árvore {.t}

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
/// Devolve a altura de *r*. A altura de uma
/// árvore binária é a distância da raiz a seu
/// descendente mais afastado. Uma árvore com
/// um único nó tem altura 0.
fn altura(r: Arvore(a)) -> Int {
  todo
}

```

\pause

</div>
<div class="column" width="48%">

\scriptsize

```gleam
fn altura_examples() {
  //     t4  3
  //       /   \
  //  t3  4     7  t2
  //     /     / \
  //    3     8   9  t1
  //             /
  //        t0  10
  let t0 = No(10, Vazia, Vazia)
  let t1 = No(9, t0, Vazia)
  let t2 = No(7, No(8, Vazia, Vazia), t1)
  let t3 = No(4, No(3, Vazia, Vazia), Vazia)
  let t4 = No(3, t3, t2)
  check.eq(altura(Vazia), todo)
  check.eq(altura(t0), 0)
  check.eq(altura(t1), 1)
  check.eq(altura(t2), 2)
  check.eq(altura(t3), 1)
  check.eq(altura(t4), 3)
}
```

</div>
</div>


## Exemplo: altura árvore {.t}

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
/// Devolve a altura de *r*. A altura de uma
/// árvore binária é a distância da raiz a seu
/// descendente mais afastado. Uma árvore com
/// um único nó tem altura 0.
fn altura(r: Arvore(a)) -> Int {
  case r {
    Vazia -> todo
    No(valor, esq, dir) -> {
      todo
      valor
      altura(esq)
      altura(dir)
    }
  }
}

```

</div>
<div class="column" width="48%">

\scriptsize

```gleam
fn altura_examples() {
  //     t4  3
  //       /   \
  //  t3  4     7  t2
  //     /     / \
  //    3     8   9  t1
  //             /
  //        t0  10
  let t0 = No(10, Vazia, Vazia)
  let t1 = No(9, t0, Vazia)
  let t2 = No(7, No(8, Vazia, Vazia), t1)
  let t3 = No(4, No(3, Vazia, Vazia), Vazia)
  let t4 = No(3, t3, t2)
  check.eq(altura(Vazia), todo)
  check.eq(altura(t0), 0)
  check.eq(altura(t1), 1)
  check.eq(altura(t2), 2)
  check.eq(altura(t3), 1)
  check.eq(altura(t4), 3)
}
```

</div>
</div>


## Exemplo: altura árvore {.t}

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
/// Devolve a altura de *r*. A altura de uma
/// árvore binária é a distância da raiz a seu
/// descendente mais afastado. Uma árvore com
/// um único nó tem altura 0.
fn altura(r: Arvore(a)) -> Int {
  case r {
    Vazia -> todo
    No(_, esq, dir) ->
      1 + int.max(altura(esq), altura(dir))
    }
  }
}

```

</div>
<div class="column" width="48%">

\scriptsize

```gleam
fn altura_examples() {
  //     t4  3
  //       /   \
  //  t3  4     7  t2
  //     /     / \
  //    3     8   9  t1
  //             /
  //        t0  10
  let t0 = No(10, Vazia, Vazia)
  let t1 = No(9, t0, Vazia)
  let t2 = No(7, No(8, Vazia, Vazia), t1)
  let t3 = No(4, No(3, Vazia, Vazia), Vazia)
  let t4 = No(3, t3, t2)
  check.eq(altura(Vazia), todo)
  check.eq(altura(t0), 0)
  check.eq(altura(t1), 1)
  check.eq(altura(t2), 2)
  check.eq(altura(t3), 1)
  check.eq(altura(t4), 3)
}
```

</div>
</div>


## Exemplo: altura árvore {.t}

<div class="columns">
<div class="column" width="48%">
\scriptsize

```gleam
/// Devolve a altura de *r*. A altura de uma
/// árvore binária é a distância da raiz a seu
/// descendente mais afastado. Uma árvore com
/// um único nó tem altura 0 e uma árvore vazia
/// tem altura -1.
fn altura(r: Arvore(a)) -> Int {
  case r {
    Vazia -> -1
    No(_, esq, dir) ->
      1 + int.max(altura(esq), altura(dir))
  }
}

```

</div>
<div class="column" width="48%">

\scriptsize

```gleam
fn altura_examples() {
  //     t4  3
  //       /   \
  //  t3  4     7  t2
  //     /     / \
  //    3     8   9  t1
  //             /
  //        t0  10
  let t0 = No(10, Vazia, Vazia)
  let t1 = No(9, t0, Vazia)
  let t2 = No(7, No(8, Vazia, Vazia), t1)
  let t3 = No(4, No(3, Vazia, Vazia), Vazia)
  let t4 = No(3, t3, t2)
  check.eq(altura(Vazia), -1)
  check.eq(altura(t0), 0)
  check.eq(altura(t1), 1)
  check.eq(altura(t2), 2)
  check.eq(altura(t3), 1)
  check.eq(altura(t4), 3)
}
```

</div>
</div>


Árvores
=======


## Árvores

<div class="columns">
<div class="column" width="45%">
Projete um tipo de dado para representar um diretório ou arquivo em um sistema de arquivos.

</div>
<div class="column" width="45%">
\scriptsize

```
disciplinas/
+- 12026/
|  +- alunos.txt
|  +- trabs/
|     +- trab1.md
|     +- correcoes/
|     |  +- rascunho.txt
|     |  +- final.txt
|     +- trab2.md
+- 6879/
+- 6884/
+- anotacoes.txt
```

</div>
</div>


## Árvores {.t}

<div class="columns">
<div class="column" width="48%">

\small

Uma **entrada** no sistema de arquivos é: \pause

- Um arquivo com um nome; ou \pause
- Um diretório com um nome e uma **lista de entradas**.

\pause

\ \

Uma **lista de entradas** é: \pause

- Vazia; ou \pause
- Um par com o primeiro e o resto, onde o primeiro é uma **entrada** e o resto é uma **lista de entradas**.

\pause

</div>
<div class="column" width="48%">

\scriptsize

```gleam
type Entrada {
  Arq(String)
  Dir(String, List(Entrada))
}
```

</div>
</div>


## Árvores {.t}

<div class="columns">
<div class="column" width="48%">

\scriptsize

```
disciplinas/
+- 12026/
|  +- alunos.txt
|  +- trabs/
|     +- trab1.md
|     +- correcoes/
|     |  +- rascunho.txt
|     |  +- final.txt
|     +- trab2.md
+- 6879/
+- 6884/
+- anotacoes.txt
```

</div>
<div class="column" width="48%">

\scriptsize

```gleam
Dir("disciplinas", [
  Dir("12026", [
    Arq("alunos.txt"),
    Dir("trabs", [
      Arq("trab1.md"),
      Dir("correcoes", [
        Arq("rascunho.txt"),
        Arq("final.txt")
      ]),
      Arq("trab2.md"),
    ]),
  ]),
  Dir("6879", []),
  Dir("6884", []),
  Arq("anotacoes.txt"),
])
```

</div>
</div>


## Árvores {.t}

<div class="columns">
<div class="column" width="48%">

\small

Uma **entrada** no sistema de arquivos é:

- Um arquivo com um nome; ou
- Um diretório com um nome e uma **lista de entradas**.


\ \

Uma **lista de entradas** é:

- Vazia; ou
- Um par com o primeiro e o resto, onde o primeiro é uma **entrada** e o resto é uma **lista de entradas**.

</div>
<div class="column" width="48%">

\scriptsize

```gleam
fn fn_para_entrada(ent: Entrada) {
  case ent {
    Arq(nome) -> { todo nome }
    Dir(nome, entradas) -> {
      todo nome
           fn_para_entradas(entradas)
    }
  }
}
```

```gleam

fn fn_para_entradas(entradas: List(Entrada)) {
  case entradas {
    [] -> todo
    [primeiro, ..resto] -> {
      todo fn_para_entrada(primeiro)
           fn_para_entradas(resto)
    }
  }
}
```

</div>
</div>


## Exemplo: arquivos txt

Projete uma função para encontrar os caminhos para todos os arquivos `.txt`.


## Exemplo: arquivos txt {.t}

<div class="columns">
<div class="column" width="48%">
\scriptsize

```
disciplinas/
+- 12026/
|  +- alunos.txt
|  +- trabs/
|     +- trab1.md
|     +- correcoes/
|     |  +- rascunho.txt
|     |  +- final.txt
|     +- trab2.md
+- 6879/
+- 6884/
+- anotacoes.txt
```

\pause

\ \

```
disciplinas/12026/alunos.txt
disciplinas/12026/trabs/correcoes/rascunho.txt
disciplinas/12026/trabs/correcoes/final.txt
disciplinas/anotacoes.txt
```

\pause

</div>
<div class="column" width="48%">
\scriptsize

```gleam
fn encontra_txt(ent: Entrada) -> List(String) {
  todo
}
```

</div>
</div>


## Exemplo: arquivos txt {.t}

<div class="columns">
<div class="column" width="48%">
\scriptsize

```
disciplinas/
+- 12026/
|  +- alunos.txt
|  +- trabs/
|     +- trab1.md
|     +- correcoes/
|     |  +- rascunho.txt
|     |  +- final.txt
|     +- trab2.md
+- 6879/
+- 6884/
+- anotacoes.txt
```

\ \

```
disciplinas/12026/alunos.txt
disciplinas/12026/trabs/correcoes/rascunho.txt
disciplinas/12026/trabs/correcoes/final.txt
disciplinas/anotacoes.txt
```

</div>
<div class="column" width="48%">
\scriptsize

```gleam
fn encontra_txt(ent: Entrada) -> List(String) {
  case ent {
    Arq(nome) -> { todo nome }
    Dir(nome, entradas) -> {
      todo nome
           encontra_txt_lista(entradas)
    }
  }
}
fn encontra_txt_lista(entradas: List(Entrada)) -> List(String) {
  case entradas {
    [] -> todo
    [ent, ..resto] -> {
      todo encontra_txt(ent)
           encontra_txt_lista(resto)
    }
  }
}
```

</div>
</div>


## Exemplo: arquivos txt {.t}

<div class="columns">
<div class="column" width="48%">
\scriptsize

```
disciplinas/
+- 12026/
|  +- alunos.txt
|  +- trabs/
|     +- trab1.md
|     +- correcoes/
|     |  +- rascunho.txt
|     |  +- final.txt
|     +- trab2.md
+- 6879/
+- 6884/
+- anotacoes.txt
```

\ \

```
disciplinas/12026/alunos.txt
disciplinas/12026/trabs/correcoes/rascunho.txt
disciplinas/12026/trabs/correcoes/final.txt
disciplinas/anotacoes.txt
```

</div>
<div class="column" width="48%">
\scriptsize

```gleam
fn encontra_txt(ent: Entrada) -> List(String) {
  case ent {
    Arq(nome) -> case string.ends_with(nome, ".txt") {
      False -> []
      True -> [nome] }
    Dir(nome, entradas) -> {
      todo nome
           encontra_txt_lista(entradas)
    }
  }
}
fn encontra_txt_lista(entradas: List(Entrada)) -> List(String) {
  case entradas {
    [] -> []
    [ent, ..resto] -> {
      todo encontra_txt(ent)
           encontra_txt_lista(resto)
    }
  }
}
```

</div>
</div>


## Exemplo: arquivos txt {.t}

<div class="columns">
<div class="column" width="48%">
\scriptsize

```
disciplinas/
+- 12026/
|  +- alunos.txt
|  +- trabs/
|     +- trab1.md
|     +- correcoes/
|     |  +- rascunho.txt
|     |  +- final.txt
|     +- trab2.md
+- 6879/
+- 6884/
+- anotacoes.txt
```

\ \

```
disciplinas/12026/alunos.txt
disciplinas/12026/trabs/correcoes/rascunho.txt
disciplinas/12026/trabs/correcoes/final.txt
disciplinas/anotacoes.txt
```

</div>
<div class="column" width="48%">
\scriptsize

```gleam
fn encontra_txt(ent: Entrada) -> List(String) {
  case ent {
    Arq(nome) ->
      case string.ends_with(nome, ".txt") {
        False -> []
        True -> [nome]
      }
    Dir(nome, entradas) ->
      adiciona_prefixo(nome,
                       encontra_txt_lista(entradas))
  }
}
fn encontra_txt_lista(entradas: List(Entrada)) -> List(String) {
  case entradas {
    [] -> []
    [ent, ..resto] ->
      list.append(encontra_txt(ent),
                  encontra_txt_lista(resto))
  }
}
```

</div>
</div>


Revisão
=======


## Revisão

Como é definida uma árvore binária? \pause

- Uma árvore binária é vazia ou é um nó com um valor e duas árvores binárias, uma à esquerda e outra à direita. \pause

Qual é o modelo de função para árvores binárias? \pause

- Um `case`{.gleam} com um caso para a árvore vazia e outro para o nó. No caso do nó, são feitas duas chamadas recursivas, uma para cada subárvore.


## Revisão

O que é uma autorreferência indireta? \pause

- É quando um tipo se refere a si mesmo por meio de outro tipo. Uma entrada no sistema de arquivos é definida em termos de uma lista de entradas, que é definida em termos de entrada. \pause

Qual é o modelo de função para tipos com autorreferência indireta? \pause

- Uma função para cada tipo, cada uma seguindo a definição do seu tipo. Onde um tipo se refere ao outro, uma função chama a outra (recursão mútua).


Referências
===========

## Referências

Básicas

- Capítulos [19 e 20](https://htdp.org/2022-8-7/Book/part_four.html) do livro [HTDP](http://htdp.org)

Complementares

- Seção [2.2.2](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-15.html#%_sec_2.2.2) do livro [SICP](https://mitpress.mit.edu/sicp/)
