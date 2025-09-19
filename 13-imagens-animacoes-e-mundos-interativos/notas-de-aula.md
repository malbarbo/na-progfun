---
# vim: set spell spelllang=pt_br sw=4:
title: Imagens, animações e programas interativos
---

Introdução
==========

## Introdução

O sgleam permite a criação de imagens. \pause

O sgleam web permite a criação e exibição de imagens, animações e programas interativos. \pause


## Definições

Uma **imagem** é um dado visual e retangular. \pause Pode ser uma foto, um desenho, uma figura geométrica ou um texto. \pause

Uma **animação** é a exibição contínua de imagens estáticas que variam de forma sequencial criando a ilusão de movimento. \pause

Um **programa interativo** é um programa que reage a ações do usuário modificando seu comportamento e saída de acordo com as entradas recebidas.


Imagens
=======

## Introdução

O sgleam fornece várias funções para criação de imagens geométricas básicas, como retângulos, elipses, polígonos e textos. Também fornece funções para transformar e combinar imagens, como rotacionar, espelhar, colocar uma ao lado da outra, entre outras. \pause

As funções para criar e transformar imagens estão no módulo `sgleam/image`{.gleam}. \pause

Uma forma geométrica tem um estilo, que incluí um contorno (_stroke_) e um preenchimento (_fill_). O contorno tem uma cor, uma espessura e outros atributos. O preenchimento pode ou não ter uma cor. \pause

As constantes e funções para especificar o contorno estão no módulo `sgleam/stroke`{.gleam} e para o preenchimento em `sgleam/fill`{.gleam}. Funções mais gerais para o estilo estão no módulo `sgleam/style`{.gleam} e para cores no módulo `sgleam/color`{.gleam}.


## Criando uma imagem

<div class="columns">
<div class="column" width="48%">

```sgleam_image
rectangle1
> image.rectangle(50, 70, fill.blue)
```

</div>
<div class="column" width="48%">
</div>
</div>
