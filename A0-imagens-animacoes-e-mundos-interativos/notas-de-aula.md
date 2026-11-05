---
# vim: set spell spelllang=pt_br sw=4:
title: Imagens, animações e programas interativos
---

Introdução
==========

## Introdução

O sgleam permite a criação e exibição de imagens, animações e programas interativos, tanto na versão web quanto na linha de comando.


## Definições

Uma **imagem** é um dado visual e retangular. \pause Pode ser uma foto, um desenho, uma figura geométrica ou um texto. \pause

Uma **animação** é a exibição contínua de imagens estáticas que variam de forma sequencial criando a ilusão de movimento. \pause

Um **programa interativo** é um programa que reage a ações do usuário modificando seu comportamento e saída de acordo com as entradas recebidas.


## Aviso

Esta parte do sgleam é experimental, então pode conter erros. Se você identificar alguma falha, comunique ao professor.


Imagens
=======

## Introdução

O sgleam fornece várias funções para criação de imagens geométricas básicas, como retângulos, elipses, polígonos e textos. Também fornece funções para transformar e combinar imagens, como rotacionar, espelhar, colocar uma ao lado da outra, entre outras. \pause

As funções para criar, combinar e transformar imagens estão no módulo `sgleam/image`{.gleam}. \pause

Uma forma geométrica tem um estilo, que inclui um contorno (_stroke_) e um preenchimento (_fill_). O contorno tem uma cor, uma espessura e outros atributos. O preenchimento pode ou não ter uma cor. \pause

As constantes e funções para especificar o contorno estão no módulo `sgleam/stroke`{.gleam} e para o preenchimento em `sgleam/fill`{.gleam}. Funções mais gerais para o estilo estão no módulo `sgleam/style`{.gleam} e para cores no módulo `sgleam/color`{.gleam}.


## Quadrado e retângulo

```sgleam_image
> image.square(60, stroke.red) // lado
```

\pause

```sgleam_image
> image.rectangle(20, 60, fill.blue) // largura e altura
```

\pause

```sgleam_image
> image.rectangle(100, 30, style.join([stroke.black, fill.gray]))
```


## Dimensões

```gleam-repl
> let r = image.rectangle(20, 60, fill.blue)
```

\pause

```gleam-repl
> image.width(r)
20
> image.widthf(r)
20.0
```


\pause
```gleam-repl
> image.height(r)
60
> image.heightf(r)
60.0
```


## Círculo e elipse

```sgleam_image
> image.circle(30, stroke.red) // raio
```

\pause

```sgleam_image
> image.ellipse(30, 50, stroke.purple) // largura e altura
```

\pause

```sgleam_image
> image.circlef(20.0, fill.slateblue) // funções que terminam com f
                                      // os argumentos são Float
```


## Linha

```sgleam_image
> image.line(20, 50, stroke.black) // (0, 0) para (20, 50)
                                   // y aumenta para baixo
```

\pause

```sgleam_image
> image.line(20, -50, style.join([stroke.olive, stroke.width(6)]))
```


## Polígonos

```sgleam_image
> image.triangle(40, stroke.tan) // lado
```

\pause

```sgleam_image
> image.right_triangle(30, 60, fill.yellowgreen) // base e altura
```

\pause

```sgleam_image
> image.isosceles_triangle(60, 150, fill.seagreen) // lados iguais e
                                                   // ângulo entre eles
```


## Polígonos

```sgleam_image
> image.rhombus(50, 30, stroke.magenta) // lado e ângulo (superior
                                        //                e inferior)
```

\pause

```sgleam_image
> image.rhombus(60, 120, fill.cornflowerblue) // lado e ângulo (superior
                                              //                e inferior)
```


## Polígonos

```sgleam_image
> image.polygon(
    [Point(0, 0), Point(-10, 20), Point(60, 0), Point(-10, -20)],
    fill.burlywood,
  )
```


## Polígonos

```sgleam_image
> image.regular_polygon(60, 5, fill.chocolate) // lado e número de lados
```

\pause

```sgleam_image
> image.regular_polygon(40, 8, stroke.navy) // lado e número de lados
```


## Polígonos

```sgleam_image
> image.star(40, fill.firebrick) // estrela circunscrita em um polígono
                                 // de lado 40
```

\pause

```sgleam_image
> image.radial_star(9, 20, 40, stroke.darkslategray) // número de pontas,
                                                     // raio interno e
                                                     // raio externo
```

## Polígonos

```sgleam_image
> image.star_polygon(40, 7, 3, stroke.seagreen) // estrela circunscrita em
                                                // um polígono de 7 lados
                                                // vértices ligados de
                                                // 3 em 3
```


## Texto

```sgleam_image
> image.text("Casa", 20, fill.black) // texto e tamanho da fonte
```

\pause

```sgleam_image
> image.text("aTa", 30, stroke.darkgreen) // texto e tamanho da fonte
```

\pause

```sgleam_image
> image.text_font(
    "gleam",
    font.Font(..font.default(), size: 25.0, family: "monospace"),
    style.join([stroke.red, fill.black]),
  )
```


## Combinações

```sgleam_image
> image.beside( // ao lado
    image.rectangle(20, 30, fill.blue),
    image.circle(10, fill.red),
)
```

\pause

```sgleam_image
> image.above( // acima
    image.rectangle(20, 30, fill.blue),
    image.circle(10, fill.red),
)
```


## Combinações

De forma equivalente, usando _pipeline_

```sgleam_image
> image.rectangle(20, 30, fill.blue)
  |> image.beside(image.circle(10, fill.red))
```

```sgleam_image
> image.rectangle(20, 30, fill.blue)
  |> image.above(image.circle(10, fill.red))
```


## Combinações

Ao lado com posicionamento no eixo y.

\small


```sgleam_image
  image.ellipse(20, 70, fill.lightsteelblue)
  |> image.beside_align(yplace.Bottom, image.ellipse(20, 50, fill.mediumslateblue))
  |> image.beside_align(yplace.Bottom, image.ellipse(20, 30, fill.slateblue))
  |> image.beside_align(yplace.Bottom, image.ellipse(20, 10, fill.navy))
```

\normalsize

`yplace` é um módulo que define o tipo `YPlace`{.gleam} com as variantes `Top`{.gleam}, `Bottom`{.gleam} e `Middle`{.gleam}.


## Combinações

Acima com posicionamento no eixo x.

\small

```sgleam_image
> image.ellipse(70, 20, fill.yellowgreen)
  |> image.above_align(xplace.Right, image.ellipse(50, 20, fill.olivedrab))
  |> image.above_align(xplace.Right, image.ellipse(30, 20, fill.darkolivegreen))
  |> image.above_align(xplace.Right, image.ellipse(10, 20, fill.darkgreen))
```

\normalsize

`xplace` é um módulo que define o tipo `XPlace`{.gleam} com as variantes `Right`{.gleam}, `Left`{.gleam} e `Center`{.gleam}.


## Combinações

Sobreposição.

\small

```sgleam_image
> image.rectangle(30, 60, fill.orange)
  |> image.overlay(image.ellipse(60, 30, fill.purple))
```


## Combinações

Sobreposição com posicionamento no eixo x e y.

\small

```sgleam_image
> image.rectangle(30, 60, style.join([fill.orange, fill.opacityf(0.75)]))
  |> image.overlay_align(
    xplace.Left,
    yplace.Middle,
    image.ellipse(60, 30, fill.purple),
  )
```


## Combinações

\small

Os cantos superiores esquerdos começam no mesmo ponto, a segunda imagem é transladada.

```sgleam_image
> image.rectangle(40, 60, stroke.red)
  |> image.overlay_xy(25, 10, image.rectangle(20, 20, fill.black))
```


## Combinações

\small

Coloca o centro da segunda imagem na posição especificada.

```sgleam_image
> image.square(48, fill.lightgray)
  |> image.place_image(24, 24, image.triangle(32, fill.red))
```


## Combinações

\small

Coloca o ponto dado por `xplace` e `yplace` da segunda imagem na posição especificada.

```sgleam_image
> image.rectangle(64, 64, fill.palegoldenrod)
  |> image.place_image_align(
    64,
    64,
    xplace.Right,
    yplace.Bottom,
    image.triangle(48, fill.yellowgreen),
  )
```

## Transformações

Escala.

```sgleam_image
> image.ellipse(20, 30, fill.blue)
  |> image.scale(2)
  |> image.beside(image.ellipse(40, 60, fill.blue))
```

\pause

```sgleam_image
> image.text("teste", 16, fill.black) |> image.scale_xyf(2.5, 1.2)
```


## Transformações

Rotaciona no sentido anti-horário.

```sgleam_image
> image.rectangle(20, 60, fill.blue) |> image.rotate(30)
```


## Transformações

Espelha na horizontal.

\small

```sgleam_image
> image.beside(
    image.square(50, fill.red) |> image.rotate(30),
    image.square(50, fill.blue) |> image.rotate(30) |> image.flip_horizontal,
)
```


## Transformações

Espelha na vertical.

\small

```sgleam_image
> image.above(
    image.star(40, fill.firebrick),
    image.star(40, fill.gray) |> image.flip_vertical |> image.scale_xyf(1.0, 0.5),
)
```


## Utilidades

Coloca um quadro ao redor da imagem, útil para depuração.

```sgleam_image
> image.frame(image.star(30, stroke.firebrick))
```

\pause

Cria um quadro que pode ser usado como fundo para colocar outras imagens.

```sgleam_image
> image.empty_scene(70, 50)
```


## Construindo uma casa

Uma casa simples.

\small

```sgleam_image
> image.triangle(40, fill.red)
  |> image.above(image.rectangle(40, 30, fill.black))
```


## Construindo uma casa

Uma casa com dois telhados.

\small

```sgleam_image
> image.triangle(40, fill.red)
  |> image.beside(image.triangle(40, fill.red))
  |> image.above(image.rectangle(80, 30, fill.black))
```


## Construindo uma casa

Se os telhados não forem do mesmo tamanho, eles não ficam alinhados.

\small

```sgleam_image
> image.triangle(40, fill.red)
  |> image.beside(image.triangle(30, fill.red))
  |> image.above(image.rectangle(70, 30, fill.black))
```


## Construindo uma casa

Se os telhados não forem do mesmo tamanho, eles não ficam alinhados.

\small

```sgleam_image
> let casa = image.triangle(40, fill.red)
  |> image.beside_align(yplace.Bottom, image.triangle(30, fill.red))
  |> image.above(image.rectangle(70, 30, fill.black))
```


## Construindo uma casa

Colocando uma porta.

\small

```gleam-repl
> let porta = image.rectangle(15, 25, fill.saddlebrown)
``````

```sgleam_image
let casa = image.triangle(40, fill.red)
  |> image.beside_align(yplace.Bottom, image.triangle(30, fill.red))
  |> image.above(image.rectangle(70, 30, fill.black))
let porta = image.rectangle(15, 25, fill.saddlebrown)

> image.overlay_align(porta, xplace.Center, yplace.Bottom, casa)
```


## Construindo uma casa

Colocando uma porta, agora com maçaneta.

\small

```gleam-repl
> let porta_macaneta = image.overlay_align(
    image.circle(3, fill.yellow),
    xplace.Right,
    yplace.Middle,
    porta,
  )
``````

```sgleam_image
let casa = image.triangle(40, fill.red)
  |> image.beside_align(yplace.Bottom, image.triangle(30, fill.red))
  |> image.above(image.rectangle(70, 30, fill.black))
let porta = image.rectangle(15, 25, fill.saddlebrown)
let porta_macaneta = image.overlay_align(image.circle(3, fill.yellow), xplace.Right, yplace.Middle, porta)

> image.overlay_align(porta_macaneta, xplace.Center, yplace.Bottom, casa)
```


## Salvando imagens

No sgleam (linha de comando) é possível salvar as imagens no formato svg.

\pause

Por exemplo, dado o arquivo `estrela.gleam` abaixo

\small

```gleam
import sgleam/image
import sgleam/fill

pub fn smain() {
  image.star(40, fill.firebrick)
  |> image.to_svg()
}
```

\pause

\normalsize

Execute

\small

```sh
sgleam estrela.gleam > estrela.svg
```


## Cores

![](imagens/cores.pdf)


## Cores

Cores também podem ser criadas usando valores rgb ou rgba.

\footnotesize

```gleam-repl
> let verde = color.rgb(0, 255, 0) // valores entre 0 e 255
> let laranja = color.rgba(255, 165, 0, 0.7) // opacidade entre 0 e 1
> let estilo = style.join([
    fill.with(verde), // com uma cor existente
    stroke.rgb(100, 100, 100), // diretamente com rgb
    stroke.width(5),
  ])

```

\pause

```sgleam_image
let verde = color.rgb(0, 255, 0) // valores entre 0 e 255
let laranja = color.rgba(255, 165, 0, 0.7) // opacidade entre 0 e 1
let estilo = style.join([
  fill.with(verde), // com uma cor existente
  stroke.rgb(100, 100, 100), // diretamente com rgb
  stroke.width(5),
])

> image.circle(30, estilo)
  |> image.underlay_xy(30, 0, image.circle(30, fill.with(laranja)))
```


Animações
=========

## Animações

Uma **animação** é a exibição contínua de imagens estáticas que variam de forma sequencial criando a ilusão de movimento. \pause

A animação mais simples no sgleam é uma simulação baseada no tempo. O trabalho do programador é providenciar uma função que cria uma imagem a partir de um número natural. \pause

A função que cria uma animação está no módulo `sgleam/world`.

```gleam
pub fn animation(create_image: fn(Int) -> image.Image) -> Animation
```

\pause

A animação é executada quando a função `smain` a devolve. \pause

O relógio da animação faz 28 tiques por segundo, a cada tique a função `create_image` é chamada com o número de tiques passados desde o início da animação.


## Exemplo óvni

Vamos criar uma animação de um óvni descendo a tela (veja o arquivo `animacao_ovni.gleam`).


## Exemplo óvni

\footnotesize

```gleam
fn cena_ovni(tick: Int) -> image.Image {
  let ovni =
    image.circle(10, fill.green)
    |> image.overlay(image.rectangle(40, 4, fill.green))
  image.empty_scene(100, 80) |> image.place_image(50, tick, ovni)
}
```

\pause

<div class="columns">
<div class="column" width="33%">
\footnotesize

```sgleam_image
let cena_ovni = fn(tick: Int) -> image.Image {
  let ovni =
    image.circle(10, fill.green)
    |> image.overlay(image.rectangle(40, 4, fill.green))
  image.empty_scene(100, 80) |> image.place_image(50, tick, ovni)
}

> cena_ovni(10)
```

\pause
</div>
<div class="column" width="33%">
\footnotesize

```sgleam_image
let cena_ovni = fn(tick: Int) -> image.Image {
  let ovni =
    image.circle(10, fill.green)
    |> image.overlay(image.rectangle(40, 4, fill.green))
  image.empty_scene(100, 80) |> image.place_image(50, tick, ovni)
}

> cena_ovni(40)
```

\pause
</div>
<div class="column" width="33%">
\footnotesize

```sgleam_image
let cena_ovni = fn(tick: Int) -> image.Image {
  let ovni =
    image.circle(10, fill.green)
    |> image.overlay(image.rectangle(40, 4, fill.green))
  image.empty_scene(100, 80) |> image.place_image(50, tick, ovni)
}

> cena_ovni(70)
```

\pause
</div>
</div>

```gleam
pub fn smain() {
  world.animation(cena_ovni)
}
```


## Exemplo texto com uma letra colorida

Vamos criar uma animação que colore uma letra de um texto por vez (veja o arquivo `animacao_texto.gleam`).


## Exemplo texto com uma letra colorida

\footnotesize

```gleam
fn cena_texto(tick: Int) -> image.Image {
  let texto = "computação"
  // dividimos por 10 para desacelerar a animação
  let i = tick / 10 % string.length(texto)
  let inicio = string.slice(texto, 0, i)
  let letra = string.slice(texto, i, 1)
  let fim = string.slice(texto, i + 1, string.length(texto))
  let texto =
    image.text(inicio, 30, fill.black)
    |> image.beside(image.text(letra, 30, fill.red))
    |> image.beside(image.text(fim, 30, fill.black))
  image.empty_scene(230, 50) |> image.overlay(texto)
}
```

\pause

<div class="columns">
<div class="column" width="33%">
\footnotesize

```sgleam_image
let cena_texto = fn(tick: Int) -> image.Image {
  let texto = "computação"
  let i = tick / 10 % string.length(texto)
  let inicio = string.slice(texto, 0, i)
  let letra = string.slice(texto, i, 1)
  let fim = string.slice(texto, i + 1, string.length(texto))
  let texto =
    image.text(inicio, 30, fill.black)
    |> image.beside(image.text(letra, 30, fill.red))
    |> image.beside(image.text(fim, 30, fill.black))
  image.empty_scene(230, 50) |> image.overlay(texto)
}

> cena_texto(10)
```

\pause
</div>
<div class="column" width="33%">
\footnotesize

```sgleam_image
let cena_texto = fn(tick: Int) -> image.Image {
  let texto = "computação"
  let i = tick / 10 % string.length(texto)
  let inicio = string.slice(texto, 0, i)
  let letra = string.slice(texto, i, 1)
  let fim = string.slice(texto, i + 1, string.length(texto))
  let texto =
    image.text(inicio, 30, fill.black)
    |> image.beside(image.text(letra, 30, fill.red))
    |> image.beside(image.text(fim, 30, fill.black))
  image.empty_scene(230, 50) |> image.overlay(texto)
}

> cena_texto(40)
```

\pause
</div>
<div class="column" width="33%">
\footnotesize

```sgleam_image
let cena_texto = fn(tick: Int) -> image.Image {
  let texto = "computação"
  let i = tick / 10 % string.length(texto)
  let inicio = string.slice(texto, 0, i)
  let letra = string.slice(texto, i, 1)
  let fim = string.slice(texto, i + 1, string.length(texto))
  let texto =
    image.text(inicio, 30, fill.black)
    |> image.beside(image.text(letra, 30, fill.red))
    |> image.beside(image.text(fim, 30, fill.black))
  image.empty_scene(230, 50) |> image.overlay(texto)
}

> cena_texto(76)
```

</div>
</div>


Programas interativos
=====================

## Programas interativos

Um **programa interativo** é um programa que reage a ações do usuário modificando seu comportamento e saída de acordo com as entradas recebidas.

\pause

Para projetar um programa interativo é necessário definir três coisas: \pause

- O estado do programa e constantes; \pause
- Uma função que gera uma imagem a partir do estado do programa; \pause
- Uma função que modifica o estado do programa a partir de um evento de teclado. \pause

Opcionalmente,

- Uma função que avança o estado do programa com o passar do tempo.


## Exemplo movimento horizontal

Vamos criar um programa que exibe um quadrado que pode ser deslocado para a esquerda ou direita usando as teclas apropriadas e que alterna a cor entre verde, amarelo e vermelho 5 vezes por segundo (veja o arquivo `move_horizontal.gleam`). \pause

Começamos com um esboço do que queremos.


## Exemplo movimento horizontal

```{=latex}
\begin{center}
\begin{tikzpicture}[x=0.17mm, y=0.17mm, font=\small]
  % cenas 100 x 100 com o quadrado de lado 20 em y = 50
  % movimento com as teclas
  \foreach \cx/\qx in {0/40, 240/50, 480/60} {
    \draw (\cx, 0) rectangle +(100, 100);
    \draw[fill=green] (\cx + \qx - 10, 40) rectangle +(20, 20);
  }
  \draw[->] (220, 50) -- node[above, align=center, text depth=0.5ex] {tecla\\esquerda} (120, 50);
  \draw[->] (360, 50) -- node[above, align=center, text depth=0.5ex] {tecla\\direita} (460, 50);
  % mudança de cor a cada tique
  \foreach \cx/\cor in {0/green, 160/yellow, 320/red, 480/green} {
    \draw (\cx, -150) rectangle +(100, 100);
    \draw[fill=\cor] (\cx + 40, -110) rectangle +(20, 20);
  }
  \foreach \cx in {0, 160, 320} {
    \draw[->] (\cx + 110, -100) -- node[above] {tique} (\cx + 150, -100);
  }
\end{tikzpicture}
\end{center}
```

\pause

O que precisamos para representar o estado do programa? \pause O que muda com as interações ou com o tempo? \pause A coordenada x do centro do quadrado. \pause A cor. \pause Vamos definir uma estrutura. \pause

O que não muda? \pause O tamanho da cena e do quadrado. \pause A coordenada y do centro do quadrado. \pause A coordenada x inicial do centro do quadrado. \pause O deslocamento em cada interação.


## Exemplo movimento horizontal

<div class="columns">
<div class="column" width="48%">
\small

Estado do programa.

```gleam
pub type Quadrado {
  Quadrado(x: Int, cor: Cor)
}

pub type Cor {
  Verde
  Amarelo
  Vermelho
}
```

\pause

</div>
<div class="column" width="48%">
\small

Constantes.

```gleam
const largura = 100
const altura = 100
const deslocamento = 10
const q_lado = 20
const q_y = 50
const q_x_inicial = 50
```

</div>
</div>


## Exemplo movimento horizontal

Função que gera uma imagem a partir do estado.

\small

```gleam
pub fn desenha(q: Quadrado) -> image.Image {
  let estilo = case q.cor {
    Verde -> fill.green
    Amarelo -> fill.yellow
    Vermelho -> fill.red
  }
  image.empty_scene(largura, altura)
  |> image.place_image(q.x, q_y, image.square(q_lado, estilo))
}
```


## Exemplo movimento horizontal

\small

Função que modifica o estado a partir de um evento de teclado.

\footnotesize

```gleam
/// Desloca *q* *deslocamento* unidades para a esquerda se *tecla* for ArrowLeft
/// e para a direita se *tecla* for ArrowRight. Devolve *q* para outras teclas.
pub fn move(q: Quadrado, tecla: key.Event) -> Quadrado {
  case tecla {
    key.ArrowLeft -> Quadrado(..q, x: q.x - deslocamento)
    key.ArrowRight -> Quadrado(..q, x: q.x + deslocamento)
    _ -> q
  }
}

pub fn move_examples() {
  check.eq(move(Quadrado(50, Verde), key.ArrowLeft), Quadrado(50 - deslocamento, Verde))
  check.eq(move(Quadrado(50, Verde), key.ArrowRight), Quadrado(50 + deslocamento, Verde))
  check.eq(move(Quadrado(50, Verde), key.Enter), Quadrado(50, Verde))
}
```


## Exemplo movimento horizontal

\small

Função que modifica a cor com a passagem do tempo

\footnotesize

```gleam
/// Muda a cor de *q* da seguinte forma:
/// Verde -> Amarelo, Amarelo -> Vermelho, Vermelho -> Verde
pub fn muda_cor(q: Quadrado) -> Quadrado {
  let cor = case q.cor {
    Verde -> Amarelo
    Amarelo -> Vermelho
    Vermelho -> Verde
  }
  Quadrado(..q, cor: cor)
}
pub fn muda_cor_examples() {
  check.eq(muda_cor(Quadrado(50, Verde)), Quadrado(50, Amarelo))
  check.eq(muda_cor(Quadrado(50, Amarelo)), Quadrado(50, Vermelho))
  check.eq(muda_cor(Quadrado(50, Vermelho)), Quadrado(50, Verde))
}
```


## Exemplo movimento horizontal

\footnotesize

```gleam
pub fn smain() {
  // Cria um mundo com um estado inicial e uma função de desenho
  world.create(Quadrado(q_x_inicial, Verde), desenha)
  // move atualiza o estado quando uma tecla é pressionada
  |> world.on_key_down(move)
  // muda_cor atualiza o estado a cada tique de relógio
  |> world.on_tick(muda_cor)
  // quantas vezes o relógio faz tique por segundo
  |> world.tick_rate(5)
}
```

\small

O mundo é executado quando a função `smain` o devolve. As funções têm as seguintes assinaturas:

\footnotesize

```gleam
pub fn create(state: a, to_image: fn(a) -> Image) -> World(a)
pub fn on_key_down(world: World(a), handler: fn(a, key.Event) -> a) -> World(a)
pub fn on_tick(world: World(a), handler: fn(a) -> a) -> World(a)
pub fn tick_rate(world: World(a), rate: Int) -> World(a)
```


## Tipo `key.Event`

<div class="columns">
<div class="column" width="33%">
\small

```gleam
pub type Event {
  ArrowLeft
  ArrowRight
  ArrowUp
  ArrowDown
  PageUp
  PageDown
  Home
  End
  Backspace
  Tab
  Enter
  Escape
```

</div>
<div class="column" width="33%">

\small

```gleam
  Delete
  Insert
  F1
  F2
  F3
  F4
  F5
  F6
  F7
  F8
  F9
  F10
  F11
```

</div>
<div class="column" width="33%">

\small

```gleam
  F12
  CapsLock
  NumLock
  ScrollLock
  PrintScreen
  Pause
  Shift
  Control
  Alt
  Meta
  Char(String)
}
```

</div>
</div>


Mundos multijogador
===================

## Mundos multijogador

Um **mundo multijogador** é um programa interativo do qual vários jogadores participam ao mesmo tempo. \pause

Ele funciona como os programas interativos que vimos, com um único estado, compartilhado por todos os jogadores. As diferenças são: \pause

- A função que trata as teclas recebe também o jogador que pressionou a tecla; \pause
- A função de desenho é chamada uma vez para cada jogador e recebe o jogador, de modo que cada um pode ver uma imagem diferente. \pause

As funções para criar um mundo multijogador estão no módulo `sgleam/mworld`{.gleam}.


## Exemplo sinal vermelho

Vamos criar um jogo de corrida para 2 a 4 jogadores (veja o arquivo `sinal_vermelho.gleam`). \pause

- Cada jogador tem um corredor na sua própria raia; \pause
- Um sinal alterna entre verde e vermelho a cada segundo; \pause
- Cada vez que o jogador pressiona espaço, o seu corredor avança um passo se o sinal está verde, ou volta para o início da raia se o sinal está vermelho; \pause
- Vence quem chegar primeiro à linha de chegada, a 20 passos do início. \pause

O jogo tem três fases: a abertura, a corrida e o resultado. Na abertura e no resultado, o jogador 1 pressiona Enter e começa uma contagem de 3 segundos para a corrida.


## Exemplo sinal vermelho

Começamos com um esboço das telas. Cada jogador vê a sua raia destacada.

```{=latex}
\begin{center}
\begin{tikzpicture}[x=0.17mm, y=0.17mm, font=\scriptsize]
  % abertura
  \draw (0, 0) rectangle +(220, 150);
  \node at (110, 115) {\small Sinal vermelho};
  \node[align=center] at (110, 80) {regras\\Você é ana};
  \node[align=center] at (110, 35) {Enter para começar\\ou 3, 2, 1, Já!};
  \node[below] at (110, -5) {abertura (ana)};
  % corrida vista pelo jogador 1
  \draw (260, 0) rectangle +(220, 150);
  \draw[fill=green] (370, 125) circle (12);
  \draw[fill=yellow!20] (260, 75) rectangle +(220, 30);
  \draw (260, 45) rectangle +(220, 30);
  \draw (260, 15) rectangle +(220, 30);
  \draw[very thick] (455, 15) -- (455, 105);
  \fill[blue] (320, 90) circle (7);
  \fill[orange] (380, 60) circle (7);
  \fill[violet] (290, 30) circle (7);
  \node[below] at (370, -5) {corrida (ana)};
  % resultado
  \draw (520, 0) rectangle +(220, 150);
  \node at (630, 90) {\small Você venceu!};
  \node at (630, 50) {Enter para correr novamente};
  \node[below] at (630, -5) {resultado (ana)};
\end{tikzpicture}
\end{center}
```

\pause

\small

O esboço mostra as informações necessárias para desenhar cada tela, e elas precisam estar no estado do jogo.


## Exemplo sinal vermelho

Para representar o estado do jogo, identificamos o que muda com as interações ou com o tempo: \pause a contagem, \pause a quantidade de passos de cada corredor, \pause a cor do sinal \pause e a fase do jogo (abertura, corrida ou resultado). \pause

O que não muda são \pause a quantidade de passos até a chegada, o tamanho de um passo e o tamanho das raias e da tela, que são constantes. \pause Os jogadores também não mudam, mas eles só são conhecidos quando o programa começa, então também fazem parte do estado. \pause

Cada fase precisa de informações diferentes: \pause

- Abertura: os jogadores e a contagem, que pode não ter começado; \pause
- Corrida: os corredores e o sinal; \pause
- Resultado: os corredores na posição final, para saber quem venceu e para começar outra corrida com os mesmos jogadores.


## Exemplo sinal vermelho

<div class="columns">
<div class="column" width="52%">
\footnotesize

```gleam
pub type Estado {
  Abertura(
    jogadores: List(Player),
    segundos: Option(Int),
  )
  Corrida(
    corredores: List(Corredor),
    sinal: Sinal,
  )
  Resultado(corredores: List(Corredor))
}
```

</div>
<div class="column" width="44%">
\footnotesize

```gleam
pub type Corredor {
  Corredor(jogador: Player, passos: Int)
}

pub type Sinal {
  Verde
  Vermelho
}
```

</div>
</div>

\pause

\small

Cada fase é uma variante do tipo `Estado`, com os seus próprios campos. \pause Na abertura, `segundos` é `None`{.gleam} enquanto a contagem não começou. \pause A quantidade de jogadores pode variar, por isso usamos listas. \pause

O tipo `Player`, do módulo `sgleam/mworld`{.gleam}, representa um jogador. As constantes (`chegada`, `passo`, `contagem`, etc) estão no arquivo `sinal_vermelho.gleam`.


## Exemplo sinal vermelho

Antes de escrever as funções, analisamos o que cada evento muda em cada fase.

\footnotesize

| Fase      | Enter do jogador 1   | Espaço do jogador *j*                    | Tique                       |
|-----------|----------------------|------------------------------------------|-----------------------------|
| Abertura  | começa a contagem    | nada                                     | avança a contagem           |
|           | (se não começou)     |                                          | (depois do 0, corrida)      |
| Corrida   | nada                 | verde: *j* avança (se chegou, resultado) | o sinal troca               |
|           |                      | vermelho: *j* volta para o início        |                             |
| Resultado | recomeça (contagem   | nada                                     | nada                        |
|           | com os mesmos)       |                                          |                             |

\normalsize

\pause

Cada célula diferente de "nada" é uma ação, que será feita por uma função. \pause As funções que tratam os eventos apenas **despacham**: verificam a fase e o evento e chamam a função que faz a ação.


## Exemplo sinal vermelho

\footnotesize

```gleam
/// Trata a *tecla* pressionada por *jogador*: Enter do jogador 1 começa a
/// contagem (abertura e resultado) e espaço move o corredor (corrida).
pub fn trata_tecla(estado: Estado, jogador: Player, tecla: key.Event) -> Estado {
  let primeiro = mworld.player_index(jogador) == 1
  case estado, tecla {
    Abertura(jogadores, None), key.Enter if primeiro ->
      comeca_contagem(jogadores)
    Resultado(corredores), key.Enter if primeiro ->
      recomeca(corredores)
    Corrida(corredores, sinal), key.Char(" ") -> move(corredores, sinal, jogador)
    _, _ -> estado
  }
}
```

\small

A função `mworld.player_index`{.gleam} devolve o índice do jogador (de 1 até a quantidade de jogadores). \pause Uma guarda não pode chamar funções, por isso calculamos `primeiro` antes do `case`{.gleam}.


## Exemplo sinal vermelho

\small

Funções que fazem as ações da tecla Enter.

\footnotesize

```gleam
/// Começa a contagem para a corrida dos *jogadores*.
pub fn comeca_contagem(jogadores: List(Player)) -> Estado {
  Abertura(jogadores, Some(contagem))
}

/// Começa a contagem para uma nova corrida com os jogadores dos *corredores*.
pub fn recomeca(corredores: List(Corredor)) -> Estado {
  comeca_contagem(list.map(corredores, fn(c) { c.jogador }))
}
```


## Exemplo sinal vermelho

\small

Nos exemplos, criamos jogadores com `mworld.fake_player(indice, apelido)`{.gleam}, que devolve um `Result`{.gleam}. Usamos `let assert`{.gleam} para obter o jogador.

\footnotesize

```gleam
pub fn comeca_contagem_examples() {
  let assert Ok(ana) = mworld.fake_player(1, "ana")
  let assert Ok(bia) = mworld.fake_player(2, "bia")
  check.eq(comeca_contagem([ana, bia]), Abertura([ana, bia], Some(3)))
}

pub fn recomeca_examples() {
  let assert Ok(ana) = mworld.fake_player(1, "ana")
  let assert Ok(bia) = mworld.fake_player(2, "bia")
  check.eq(recomeca([Corredor(ana, 3), Corredor(bia, 20)]), Abertura([ana, bia], Some(3)))
}
```

\small

O `let assert`{.gleam} interrompe o programa se o valor não é `Ok`{.gleam}, por isso só é usado nos exemplos.


## Exemplo sinal vermelho

\small

Os exemplos verificam a função chamada para cada combinação de fase e evento.

\footnotesize

```gleam
pub fn trata_tecla_examples() {
  let assert Ok(ana) = mworld.fake_player(1, "ana")
  let assert Ok(bia) = mworld.fake_player(2, "bia")
  let cs = [Corredor(ana, 3), Corredor(bia, 19)]
  let fim = [Corredor(ana, 3), Corredor(bia, 20)]
  let abertura = Abertura([ana, bia], None)
  check.eq(trata_tecla(abertura, ana, key.Enter), comeca_contagem([ana, bia]))
  check.eq(trata_tecla(abertura, bia, key.Enter), abertura)
  check.eq(trata_tecla(Corrida(cs, Verde), bia, key.Char(" ")), move(cs, Verde, bia))
  check.eq(trata_tecla(Corrida(cs, Verde), ana, key.Enter), Corrida(cs, Verde))
  check.eq(trata_tecla(Resultado(fim), ana, key.Enter), recomeca(fim))
  check.eq(trata_tecla(Resultado(fim), bia, key.Enter), Resultado(fim))
}
```


## Exemplo sinal vermelho

\small

Função que faz a ação da tecla espaço.

\footnotesize

```gleam
/// Move o corredor do *jogador*: com o *sinal* verde, ele avança um passo e,
/// se chegou, a corrida termina; com o vermelho, volta ao início.
pub fn move(corredores: List(Corredor), sinal: Sinal, jogador: Player) -> Estado {
  case sinal {
    Vermelho -> Corrida(muda_passos(corredores, jogador, fn(_) { 0 }), Vermelho)
    Verde -> {
      let corredores = muda_passos(corredores, jogador, fn(p) { p + 1 })
      case list.any(corredores, chegou) {
        True -> Resultado(corredores)
        False -> Corrida(corredores, Verde)
      }
    }
  }
}
```


## Exemplo sinal vermelho

\footnotesize

```gleam
pub fn move_examples() {
  let assert Ok(ana) = mworld.fake_player(1, "ana")
  let assert Ok(bia) = mworld.fake_player(2, "bia")
  let cs = [Corredor(ana, 3), Corredor(bia, 19)]
  // sinal verde
  check.eq(move(cs, Verde, ana), Corrida([Corredor(ana, 4), Corredor(bia, 19)], Verde))
  // sinal verde e chegada
  check.eq(move(cs, Verde, bia), Resultado([Corredor(ana, 3), Corredor(bia, 20)]))
  // sinal vermelho
  check.eq(move(cs, Vermelho, bia),
           Corrida([Corredor(ana, 3), Corredor(bia, 0)], Vermelho))
}
```

\small

A ação é a parte mais importante do jogo, por isso os exemplos cobrem cada caso da descrição. \pause

A função `chegou` devolve `True`{.gleam} se o corredor tem pelo menos `chegada` passos. A função `muda_passos` está a seguir.


## Exemplo sinal vermelho

\footnotesize

```gleam
/// Aplica *f* aos passos do corredor do *jogador*.
pub fn muda_passos(corredores: List(Corredor), jogador: Player,
                   f: fn(Int) -> Int) -> List(Corredor) {
  list.map(corredores, fn(c) {
    case c.jogador == jogador {
      True -> Corredor(jogador, f(c.passos))
      False -> c
    }
  })
}
```

\small

Dois jogadores são iguais (`==`{.gleam}) se têm o mesmo índice e o mesmo apelido.


## Exemplo sinal vermelho

\footnotesize

```gleam
pub fn muda_passos_examples() {
  let assert Ok(ana) = mworld.fake_player(1, "ana")
  let assert Ok(bia) = mworld.fake_player(2, "bia")
  let cs = [Corredor(ana, 3), Corredor(bia, 5)]
  check.eq(muda_passos([], ana, fn(p) { p + 1 }), [])
  check.eq(muda_passos(cs, ana, fn(p) { p + 1 }), [Corredor(ana, 4), Corredor(bia, 5)])
  check.eq(muda_passos(cs, bia, fn(_) { 0 }), [Corredor(ana, 3), Corredor(bia, 0)])
}
```


## Exemplo sinal vermelho

\small

Função que trata o tique. As ações são feitas pelas funções `conta` e `troca` (que troca a cor do sinal).

\footnotesize

```gleam
/// Avança o *estado* em um tique. Na abertura, se a contagem começou, ela
/// avança. Na corrida, o sinal troca de cor.
pub fn tique(estado: Estado) -> Estado {
  case estado {
    Abertura(jogadores, Some(segundos)) -> conta(jogadores, segundos)
    Corrida(corredores, sinal) -> Corrida(corredores, troca(sinal))
    _ -> estado
  }
}
```


## Exemplo sinal vermelho

\footnotesize

```gleam
pub fn tique_examples() {
  let assert Ok(ana) = mworld.fake_player(1, "ana")
  let assert Ok(bia) = mworld.fake_player(2, "bia")
  let cs = [Corredor(ana, 3), Corredor(bia, 19)]
  let fim = [Corredor(ana, 3), Corredor(bia, 20)]
  check.eq(tique(Abertura([ana, bia], None)), Abertura([ana, bia], None))
  check.eq(tique(Abertura([ana, bia], Some(2))), conta([ana, bia], 2))
  check.eq(tique(Corrida(cs, Verde)), Corrida(cs, Vermelho))
  check.eq(tique(Resultado(fim)), Resultado(fim))
}
```


## Exemplo sinal vermelho

\footnotesize

```gleam
/// Avança a contagem dos *jogadores*, que está em *segundos*. Quando chega a
/// zero, começa a corrida, com os corredores no início e o sinal verde.
pub fn conta(jogadores: List(Player), segundos: Int) -> Estado {
  case segundos {
    0 -> Corrida(list.map(jogadores, fn(j) { Corredor(j, 0) }), Verde)
    _ -> Abertura(jogadores, Some(segundos - 1))
  }
}

pub fn conta_examples() {
  let assert Ok(ana) = mworld.fake_player(1, "ana")
  let assert Ok(bia) = mworld.fake_player(2, "bia")
  check.eq(conta([ana, bia], 1), Abertura([ana, bia], Some(0)))
  check.eq(conta([ana, bia], 0), Corrida([Corredor(ana, 0), Corredor(bia, 0)], Verde))
}
```

\small

A tela mostra 3, 2, 1 e "Já!" (no 0), um por segundo, e então a corrida começa.


## Exemplo sinal vermelho

\small

A função de desenho também despacha, com uma função para cada fase.

\footnotesize

```gleam
/// Desenha a tela do *estado* para o *jogador*.
pub fn tela(estado: Estado, jogador: Player) -> Image {
  let conteudo = case estado {
    Abertura(_, segundos) -> tela_abertura(segundos, jogador)
    Corrida(corredores, sinal) -> tela_corrida(corredores, sinal, jogador)
    Resultado(corredores) -> tela_resultado(corredores, jogador)
  }
  image.overlay(conteudo, image.rectangle(largura, altura, fill.white))
}
```

\small

As funções que desenham a tela inteira são testadas no REPL, olhando a imagem para alguns estados e jogadores.


## Exemplo sinal vermelho

\small

O *jogador* é usado para escolher o que cada um vê. O vencedor vê "Você venceu!" e os outros veem o nome do vencedor, obtido com a função `nome` (a seguir).

\footnotesize

```gleam
/// Desenha a tela de resultado dos *corredores* para o *jogador*.
pub fn tela_resultado(corredores: List(Corredor), jogador: Player) -> Image {
  let mensagem = case list.find(corredores, chegou) {
    Ok(c) if c.jogador == jogador -> "Você venceu!"
    Ok(c) -> nome(c.jogador) <> " venceu!"
    Error(_) -> "Fim da corrida!"
  }
  let aviso = case mworld.player_index(jogador) {
    1 -> "Pressione Enter para correr novamente"
    _ -> "Aguardando o jogador 1 recomeçar"
  }
  empilha([texto(mensagem, 32), texto(aviso, 20)])
}
```


## Exemplo sinal vermelho

\small

O apelido devolvido por `mworld.player_nickname`{.gleam} pode ser vazio. Nesse caso, usamos o índice.

\footnotesize

```gleam
/// Devolve o apelido do *jogador*, ou "Jogador i", em que i é o índice do
/// jogador, se o apelido é vazio.
pub fn nome(jogador: Player) -> String {
  case mworld.player_nickname(jogador) {
    "" -> "Jogador " <> int.to_string(mworld.player_index(jogador))
    apelido -> apelido
  }
}

pub fn nome_examples() {
  let assert Ok(ana) = mworld.fake_player(1, "ana")
  let assert Ok(sem_apelido) = mworld.fake_player(2, "")
  check.eq(nome(ana), "ana")
  check.eq(nome(sem_apelido), "Jogador 2")
}
```


## Exemplo sinal vermelho

\small

O argumento `destaque` é `True`{.gleam} para a raia do jogador que vê a tela (veja `tela_corrida` a seguir).

\footnotesize

```gleam
/// Desenha a raia do corredor *c*, com o fundo amarelo se *destaque* é True
/// e branco caso contrário.
pub fn raia(c: Corredor, destaque: Bool) -> Image {
  let fundo = case destaque {
    True -> color.lightyellow
    False -> color.white
  }
  image.rectangle(largura, altura_raia,
                  style.join([fill.with(fundo), stroke.gray]))
  |> image.place_image(passo / 2 + c.passos * passo, altura_raia / 2,
       image.circle(passo / 2, fill.with(cor(mworld.player_index(c.jogador)))))
}
```

\small

A função `cor` devolve a cor do jogador a partir do seu índice.


## Exemplo sinal vermelho

\small

Para as funções que desenham partes pequenas da tela, escrevemos exemplos com `check.same`{.gleam}, que verifica se duas imagens são iguais.

\footnotesize

```gleam
pub fn raia_examples() {
  let assert Ok(ana) = mworld.fake_player(1, "ana")
  let assert Ok(bia) = mworld.fake_player(2, "bia")
  check.same(
    raia(Corredor(bia, 0), False),
    image.rectangle(440, 40, style.join([fill.white, stroke.gray]))
      |> image.place_image(10, 20, image.circle(10, fill.orange)),
  )
  check.same(
    raia(Corredor(ana, 3), True),
    image.rectangle(440, 40, style.join([fill.lightyellow, stroke.gray]))
      |> image.place_image(70, 20, image.circle(10, fill.blue)),
  )
}
```


## Exemplo sinal vermelho

\footnotesize

```gleam
/// Desenha a tela da corrida para o *jogador*: o *sinal* e as raias dos
/// *corredores*, com a raia do jogador destacada e a linha de chegada.
pub fn tela_corrida(corredores: List(Corredor), sinal: Sinal,
                    jogador: Player) -> Image {
  let raias = empilha(list.map(corredores, fn(c) { raia(c, c.jogador == jogador) }))
  let altura_raias = image.height(raias)
  let linha = image.rectangle(2, altura_raias, fill.black)
  let raias =
    image.place_image(raias, passo / 2 + chegada * passo,
                      altura_raias / 2, linha)
  image.above(desenha_sinal(sinal), raias)
}

/// Empilha as *imagens*, a primeira no topo.
pub fn empilha(imagens: List(Image)) -> Image {
  list.fold(imagens, image.empty, image.above)
}
```


## Exemplo sinal vermelho

\footnotesize

```gleam
pub fn smain() {
  mworld.create_from(inicio, 2, 4, tela)
  |> mworld.on_key_up(trata_tecla)
  |> mworld.on_tick(tique)
  |> mworld.tick_rate(1)
}

/// Cria o estado inicial com os *jogadores*.
pub fn inicio(_env: Env, jogadores: List(Player)) -> Estado {
  Abertura(jogadores, None)
}
```

\small

O mundo começa quando os jogadores entram, de 2 (mínimo) a 4 (máximo), e `inicio` produz o estado inicial a partir da lista dos jogadores. O `Env` (de `sgleam/env`{.gleam}) tem informações do ambiente, como um gerador de números aleatórios. \pause Com `tick_rate(1)`, o relógio faz um tique por segundo. \pause Usamos `on_key_up` porque o evento de tecla para baixo se repete enquanto a tecla está pressionada.


## Exemplo sinal vermelho

\small

Funções de `sgleam/mworld`{.gleam} usadas no exemplo:

\footnotesize

```gleam
pub fn create_from(
  init: fn(Env, List(Player)) -> a,
  min_players: Int,
  max_players: Int,
  to_image: fn(a, Player) -> Image,
) -> MultiWorld(a)
pub fn on_key_up(world: MultiWorld(a),
                 handler: fn(a, Player, key.Event) -> a) -> MultiWorld(a)
pub fn on_tick(world: MultiWorld(a), handler: fn(a) -> a) -> MultiWorld(a)
pub fn tick_rate(world: MultiWorld(a), rate: Int) -> MultiWorld(a)
pub fn player_index(player: Player) -> Int
pub fn player_nickname(player: Player) -> String
pub fn fake_player(index: Int, nickname: String) -> Result(Player, Nil)
```


Revisão
=======

## Revisão

Como criamos imagens no sgleam? \pause

- Com funções do módulo `sgleam/image`{.gleam} que criam formas básicas (retângulos, círculos, polígonos, textos), combinam imagens (`beside`, `above`, `overlay`) e as transformam (`rotate`, `scale`, `flip_horizontal`). \pause

O que é uma animação e como a criamos? \pause

- É uma sequência de imagens que dá a ilusão de movimento. Criamos com `world.animation`{.gleam}, passando uma função que produz a imagem a partir do número de tiques, e devolvemos a animação na `smain`{.gleam}.


## Revisão

Que elementos precisamos definir para projetar um programa interativo? \pause

- O estado do programa e as constantes, uma função que desenha o estado e funções que produzem um novo estado a partir de eventos (tecla pressionada, tique do relógio). \pause

Por que as funções que tratam eventos são fáceis de testar? \pause

- Porque são funções puras, que recebem o estado e devolvem um novo estado, sem desenhar nada nem depender do relógio, então podemos escrever exemplos com `check.eq`{.gleam}.


## Revisão

O que muda em um mundo multijogador em relação a um programa interativo de um jogador? \pause

- O estado continua único e compartilhado por todos, mas a função que trata as teclas recebe também o jogador que pressionou a tecla, e a função de desenho é chamada para cada jogador e recebe o jogador, de modo que cada um pode ver uma imagem diferente. \pause

Como organizamos um jogo com várias fases? \pause

- Cada fase é uma variante do tipo do estado, com os campos de que precisa. Uma tabela mostra o que cada evento faz em cada fase. As funções que tratam eventos apenas despacham: verificam a fase e o evento e chamam a função que faz a ação.
