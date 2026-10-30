import sgleam/check
import sgleam/fill
import sgleam/image
import sgleam/key
import sgleam/world

pub type Quadrado {
  Quadrado(x: Int, cor: Cor)
}

pub type Cor {
  Verde
  Amarelo
  Vermelho
}

const largura = 100

const altura = 100

const deslocamento = 10

const q_lado = 20

const q_y = 50

const q_x_inicial = 50

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

/// Produz uma cena com o quadrado *q* desenhado na posição *q.x* e na sua cor.
pub fn desenha(q: Quadrado) -> image.Image {
  let estilo = case q.cor {
    Verde -> fill.green
    Amarelo -> fill.yellow
    Vermelho -> fill.red
  }
  image.empty_scene(largura, altura)
  |> image.place_image(q.x, q_y, image.square(q_lado, estilo))
}

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
  check.eq(
    move(Quadrado(50, Verde), key.ArrowLeft),
    Quadrado(50 - deslocamento, Verde),
  )
  check.eq(
    move(Quadrado(50, Verde), key.ArrowRight),
    Quadrado(50 + deslocamento, Verde),
  )
  check.eq(move(Quadrado(50, Verde), key.Enter), Quadrado(50, Verde))
}

/// Muda a cor de *q* da seguinte forma:
/// Verde -> Amarelo
/// Amarelo -> Vermelho
/// Vermelho -> Verde
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
