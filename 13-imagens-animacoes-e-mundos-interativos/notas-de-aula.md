---
# vim: set spell spelllang=pt_br sw=4:
title: Imagens, animações e programas interativos
---

Introdução
==========

## Introdução

O sgleam permite a criação de imagens. \pause

O sgleam web permite a criação e exibição de imagens, animações e programas interativos.


## Definições

Uma **imagem** é um dado visual e retangular. \pause Pode ser uma foto, um desenho, uma figura geométrica ou um texto. \pause

Uma **animação** é a exibição contínua de imagens estáticas que variam de forma sequencial criando a ilusão de movimento. \pause

Um **programa interativo** é um programa que reage a ações do usuário modificando seu comportamento e saída de acordo com as entradas recebidas.


## Aviso

Esta parte do sglem é experimental, então pode conter erros. Se você identificar alguma falha, comunique ao professor.


Imagens
=======

## Introdução

O sgleam fornece várias funções para criação de imagens geométricas básicas, como retângulos, elipses, polígonos e textos. Também fornece funções para transformar e combinar imagens, como rotacionar, espelhar, colocar uma ao lado da outra, entre outras. \pause

As funções para criar, combinar e transformar imagens estão no módulo `sgleam/image`{.gleam}. \pause

Uma forma geométrica tem um estilo, que incluí um contorno (_stroke_) e um preenchimento (_fill_). O contorno tem uma cor, uma espessura e outros atributos. O preenchimento pode ou não ter uma cor. \pause

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


## Circulo e elipse

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
> image.line(20, 50, stroke.black) // (0, 0) para (10, 30)
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
> image.radial_star(9, 20, 40, stroke.darkslategray) // número de pontos,
                                                     // raio interno e
                                                     // raio externo
```

## Polígonos

```sgleam_image
> image.star_polygon(40, 7, 3, stroke.seagreen) // estrela circunscrita em
                                                // em um polígono de 7 lados
                                                // vertíces ligados de 3 em 3
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
  |> image.beside_align(yplace.Bottom, _, image.ellipse(20, 50, fill.mediumslateblue))
  |> image.beside_align(yplace.Bottom, _, image.ellipse(20, 30, fill.slateblue))
  |> image.beside_align(yplace.Bottom, _, image.ellipse(20, 10, fill.navy))
```

\normalsize

`yplace` é um módulo que define o tipo `YPlace` com as variantes `Top`, `Bottom` e `Middle`.


## Combinações

Acima com posicionamento no eixo x.

\small

```sgleam_image
> image.ellipse(70, 20, fill.yellowgreen)
  |> image.above_align(xplace.Right, _, image.ellipse(50, 20, fill.olivedrab))
  |> image.above_align(xplace.Right, _, image.ellipse(30, 20, fill.darkolivegreen))
  |> image.above_align(xplace.Right, _, image.ellipse(10, 20, fill.darkgreen))
```

\normalsize

`xplace` é um módulo que define o tipo `XPlace` com as variantes `Right`, `Left` e `Center`.


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
    _,
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
> image. rectangle(64, 64, fill.palegoldenrod)
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
  |> image.beside_align(yplace.Bottom, _, image.triangle(30, fill.red))
  |> image.above(image.rectangle(70, 30, fill.black))
```


## Construindo uma casa

Colocando uma porta.

\small

```gleam
> let porta = image.rectangle(15, 25, fill.saddlebrown)
``````

```sgleam_image
let casa = image.triangle(40, fill.red)
  |> image.beside_align(yplace.Bottom, _, image.triangle(30, fill.red))
  |> image.above(image.rectangle(70, 30, fill.black))
let porta = image.rectangle(15, 25, fill.saddlebrown)

> image.overlay_align(xplace.Center, yplace.Bottom, porta, casa)
```


## Construindo uma casa

Colocando uma porta, agora com maçaneta.

\small

```gleam
> let porta_macaneta = image.overlay_align(
    xplace.Right,
    yplace.Middle,
    image.circle(3, fill.yellow),
    porta)
``````

```sgleam_image
let casa = image.triangle(40, fill.red)
  |> image.beside_align(yplace.Bottom, _, image.triangle(30, fill.red))
  |> image.above(image.rectangle(70, 30, fill.black))
let porta = image.rectangle(15, 25, fill.saddlebrown)
let porta_macaneta = image.overlay_align(xplace.Right, yplace.Middle, image.circle(3, fill.yellow), porta)

> image.overlay_align(xplace.Center, yplace.Bottom, porta_macaneta, casa)
```



Animações
=========

## Animações

Uma **animação** é a exibição contínua de imagens estáticas que variam de forma sequencial criando a ilusão de movimento. \pause

A animação mais simples no sgleam é uma simulação baseada no tempo. O trabalho do programador é providenciar uma função que cria uma imagem a partir de um número natural. \pause

A função de animação está no pacote `sgleam/world`.

```gleam
pub fn animate(create_image: fn(Int) -> image.Image) -> image.Image
```

\pause

O relógio da animação faz 28 tiques por segundo, a cada tique a função `create_image` é chamada com o número de tiques passados deste o início da animação.


## Exemplo óvni

Vamos criar uma animação de um óvni descendo a tela.


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
pub fn main() {
  world.animate(cena_ovni)
}
```


## Exemplo texto com uma letra colorida

Vamos criar uma animação que colore uma letra de um texto por vez.


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

```gleam
> cena_texto(10)
```

![](imagens/cena_texto_10.pdf)

\pause
</div>
<div class="column" width="33%">
\footnotesize

```gleam
> cena_texto(40)
```

![](imagens/cena_texto_40.pdf)

\pause
</div>
<div class="column" width="33%">
\footnotesize

```gleam
> cena_texto(76)
```

![](imagens/cena_texto_76.pdf)

\pause
</div>
</div>



Programas interativos
=====================

## Programas interativos

Um **programa interativo** é um programa que reage a ações do usuário modificando seu comportamento e saída de acordo com as entradas recebidas.



Cores
=====

## Cores

![](imagens/cores.pdf)
