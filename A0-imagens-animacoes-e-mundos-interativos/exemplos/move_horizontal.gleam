import sgleam/check
import sgleam/fill
import sgleam/image
import sgleam/world

pub type Quadrado {
  Quadrado(x: Int, cor: Cor)
}

pub type Cor {
  Verde
  Vermelho
  Amarelo
}

const largura = 100

const altura = 100

const deslocamento = 10

const q_lado = 20

const q_y = 50

const q_x_inicial = 50

pub fn main() {
  // Cria um mundo com um estado inicial e uma função de desenho
  world.create(Quadrado(q_x_inicial, Verde), desenha)
  |> world.on_key_down(move)
  // move é atualiza o estado quando uma tecla é pressionada
  |> world.on_tick(muda_cor)
  // mudar_cor atualiza o estado a cada tique de relógio
  |> world.tick_rate(1)
  // quantas vezes o relógio faz tique por segundo
  |> world.run()
}

pub fn desenha(q: Quadrado) -> image.Image {
  let fill = case q.cor {
    Verde -> fill.green
    Vermelho -> fill.red
    Amarelo -> fill.yellow
  }
  image.empty_scene(largura, altura)
  |> image.put_image(q.x, q_y, image.square(q_lado, fill))
}

/// Desloca *q* para a esquerda (substrai *deslocamento* de *x*) se *tecla* for
/// ArrowLeft e para direita (soma *deslocamento* a *x*) se tecla for ArrowRight.
/// Devolve *q* para outras teclas.
pub fn move(q: Quadrado, tecla: world.Key) -> Quadrado {
  case tecla {
    world.ArrowLeft -> Quadrado(..q, x: q.x - deslocamento)
    world.ArrowRight -> Quadrado(..q, x: q.x + deslocamento)
    _ -> q
  }
}

pub fn move_examples() {
  check.eq(
    move(Quadrado(50, Verde), world.ArrowLeft),
    Quadrado(50 - deslocamento, Verde),
  )
  check.eq(
    move(Quadrado(50, Verde), world.ArrowRight),
    Quadrado(50 + deslocamento, Verde),
  )
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

pub fn mudar_cor_examples() {
  check.eq(muda_cor(Quadrado(50, Verde)), Quadrado(50, Amarelo))
  check.eq(muda_cor(Quadrado(50, Amarelo)), Quadrado(50, Vermelho))
  check.eq(muda_cor(Quadrado(50, Vermelho)), Quadrado(50, Verde))
}
