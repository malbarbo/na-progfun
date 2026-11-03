import gleam/list
import sgleam/check

/// Representa um ponto no plano cartesiano.
pub type Ponto {
  Ponto(x: Int, y: Int)
}

/// Indica quais elementos de *pontos* estão sobre o eixo x (coordenada y = 0)
/// ou eixo y (coordenada x = 0).
pub fn seleciona_no_eixo(pontos: List(Ponto)) -> List(Ponto) {
  list.filter(pontos, no_eixo)
}

fn no_eixo(p: Ponto) -> Bool {
  p.x == 0 || p.y == 0
}

pub fn seleciona_no_eixo_examples() {
  let pontos = [
    Ponto(3, 0),
    Ponto(1, 3),
    Ponto(2, 0),
    Ponto(0, 2),
    Ponto(0, 0),
    Ponto(4, 7),
  ]
  check.eq(seleciona_no_eixo(pontos), [
    Ponto(3, 0),
    Ponto(2, 0),
    Ponto(0, 2),
    Ponto(0, 0),
  ])
}
