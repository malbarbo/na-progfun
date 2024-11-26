import gleam/int
import sgleam/check

pub type Ponto {
  Ponto(x: Int, y: Int)
}

pub type Retangulo {
  Retangulo(largura: Int, altura: Int)
}

/// Determina o retângulo delimitador de altura e largura mínimas que cobre os
/// *pontos*. Se existe 0 ou 1 pontos, o retângulo terá altura e largura 0.
pub fn retangulo_delimitador(pontos: List(Ponto)) -> Retangulo {
  let xs = pontos_x(pontos)
  let ys = pontos_y(pontos)
  let menor_x = min(xs)
  let maior_x = max(xs)
  let menor_y = min(ys)
  let maior_y = max(ys)
  Retangulo(maior_x - menor_x, maior_y - menor_y)
}

/// Exemplos para testar a função `retangulo_delimitador`.
pub fn retangulo_delimitador_examples() {
  //                |
  //                |        p5
  //       p1       |
  //                |    p4
  //                | p3
  //  --------------+-------------
  //            p2  |
  //                |   p6
  //                |
  let p1 = Ponto(-10, 5)
  let p2 = Ponto(-3, -1)
  let p3 = Ponto(1, 1)
  let p4 = Ponto(4, 3)
  let p5 = Ponto(9, 8)
  let p6 = Ponto(2, -3)

  check.eq(retangulo_delimitador([]), Retangulo(0, 0))
  check.eq(retangulo_delimitador([p1]), Retangulo(0, 0))
  check.eq(retangulo_delimitador([p2, p3]), Retangulo(4, 2))
  check.eq(retangulo_delimitador([p2, p3, p6]), Retangulo(5, 4))
  check.eq(retangulo_delimitador([p2, p3, p1, p6, p4, p5]), Retangulo(19, 11))
}

// Devolve as coordenadas x de *pontos*.
fn pontos_x(pontos: List(Ponto)) -> List(Int) {
  case pontos {
    [] -> []
    [Ponto(x, _), ..resto] -> [x, ..pontos_x(resto)]
  }
}

// Devolve as coordenadas y de *pontos*.
fn pontos_y(pontos: List(Ponto)) -> List(Int) {
  case pontos {
    [] -> []
    [Ponto(_, y), ..resto] -> [y, ..pontos_y(resto)]
  }
}

// Encontra o máximo de *lst*. Se *lst* é vazia, devolve 0.
fn max(lst: List(Int)) -> Int {
  case lst {
    [] -> 0
    [p] -> p
    [primeiro, ..resto] -> int.max(primeiro, max(resto))
  }
}

// Encontra o minimo de *lst*. Se *lst* é vazia, devolve 0.
fn min(lst: List(Int)) -> Int {
  case lst {
    [] -> 0
    [p] -> p
    [primeiro, ..resto] -> int.min(primeiro, min(resto))
  }
}
