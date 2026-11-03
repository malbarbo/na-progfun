import gleam/int
import sgleam/check

/// Reduz os elementos de *lst* em um acumulador usando a função *f*. O
/// acumulador começa com *init* e é atualizado chamando *f(acc, e)* para cada
/// elemento *e* de *lst* da direita para a esquerda.
///
/// Por exemplo, a chamada reduz([4, 1, 2], 0, int.add) é equivalente a
/// *int.add(int.add(int.add(0, 2), 1), 4)*.
pub fn reduz(lst: List(a), init: b, f: fn(b, a) -> b) -> b {
  case lst {
    [] -> init
    [primeiro, ..resto] -> f(reduz(resto, init, f), primeiro)
  }
}

pub fn reduz_examples() {
  check.eq(reduz([4, 1, 2], 0, int.add), 7)
}

// Mapeia implementado com reduz.
pub fn mapeia(lst: List(a), f: fn(a) -> b) -> List(b) {
  reduz(lst, [], fn(acc, x) { [f(x), ..acc] })
}

pub fn mapeia_examples() {
  check.eq(mapeia([], fn(x) { x + 1 }), [])
  check.eq(mapeia([4], fn(x) { x * x }), [16])
  check.eq(mapeia([7, 9, 1], fn(x) { x * x }), [49, 81, 1])
}

// Filtra implementado com reduz.
pub fn filtra(lst: List(a), pred: fn(a) -> Bool) -> List(a) {
  reduz(lst, [], fn(acc, e) {
    case pred(e) {
      True -> [e, ..acc]
      False -> acc
    }
  })
}

pub fn filtra_examples() {
  check.eq(filtra([], fn(x) { x > 0 }), [])
  check.eq(filtra([1, -1, 3], fn(x) { x > 0 }), [1, 3])
  check.eq(filtra([1, -1, 3], fn(x) { x < 0 }), [-1])
}
