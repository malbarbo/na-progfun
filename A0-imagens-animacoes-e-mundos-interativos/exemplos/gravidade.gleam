import sgleam/check
import sgleam/fill
import sgleam/image
import sgleam/world

// Posição x do centro do quadrado.
type Bola {
  Bola(y: Int, velocidade: Int)
}

const largura = 200

const altura = 200

const b_raio = 10

const b_x = 100

const b_y_inicial = 10

// 2 pixels por tique
const aceleracao = 2

pub fn main() {
  world.create(Bola(b_y_inicial, 0), desenha)
  |> world.on_tick(avanca)
  |> world.on_key_down(reseta)
  |> world.run()
}

fn desenha(bola: Bola) -> image.Image {
  image.empty_scene(largura, altura)
  |> image.place_image(b_x, bola.y, image.circle(b_raio, fill.blue))
}

fn avanca(bola: Bola) -> Bola {
  // s = s0 + vt + at^2/2, onde t = 1
  let y = bola.y + bola.velocidade + aceleracao / 2
  // v = v0 + at, onde t = 1
  let velocidade = bola.velocidade + aceleracao
  // passou do limite, a velocidade muda de direção e o módulo diminui devido ao impacto
  let velocidade = case y > altura - b_raio {
    True -> velocidade * -7 / 10
    False -> velocidade
  }
  // passou do limite, a bola volta
  let y = case y > altura - b_raio {
    True -> 2 * { altura - b_raio } - y
    False -> y
  }
  Bola(y, velocidade)
}

fn reseta(bola: Bola, tecla: world.Key) -> Bola {
  case tecla {
    world.Char("r") -> Bola(b_y_inicial, 0)
    _ -> bola
  }
}
