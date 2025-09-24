import sgleam/check
import sgleam/fill
import sgleam/image
import sgleam/world

// Posição x do centro do quadrado.
type Estado =
  Int

const largura = 100

const altura = 100

const deslocamento = 10

const q_lado = 20

const q_y = 50

const q_x_inicial = 50

pub fn main() {
  world.create(q_x_inicial, desenha)
  |> world.on_key_down(move)
  |> world.run()
}

pub fn desenha(x: Estado) -> image.Image {
  image.empty_scene(largura, altura)
  |> image.place_image(x, q_y, image.square(q_lado, fill.red))
}

/// Desloca *x* para a esquerda (substrai *deslocamento*) se *tecla* for
/// ArrowLeft e para direita (soma *deslocamento*) se tecla for ArrowRight.
/// Devolve *x* para outras teclas.
pub fn move(x: Estado, tecla: world.Key) -> Estado {
  case tecla {
    world.ArrowLeft -> x - deslocamento
    world.ArrowRight -> x + deslocamento
    _ -> x
  }
}

pub fn move_examples() {
  check.eq(move(50, world.ArrowLeft), 50 - deslocamento)
  check.eq(move(50, world.ArrowRight), 50 + deslocamento)
}
