import gleam/float
import gleam/int
import sgleam/check

/// Devolve uma lista aplicando a função *f* a cada elemento da lista *lst*.
pub fn mapeia(lst: List(a), f: fn(a) -> b) -> List(b) {
  case lst {
    [] -> []
    [primeiro, ..resto] -> [f(primeiro), ..mapeia(resto, f)]
  }
}

pub fn mapeia_examples() {
  check.eq(mapeia([4, 3], int.negate), [-4, -3])
  check.eq(mapeia([3.0, 7.0], float.to_string), ["3.0", "7.0"])
}

/// Devolve uma lista com cada número de *lst* negado.
pub fn lista_nega(lst: List(Int)) -> List(Int) {
  mapeia(lst, int.negate)
}

pub fn lista_nega_examples() {
  check.eq(lista_nega([4, 3]), [-4, -3])
}

/// Devolve uma lista com cada número de *lst* transformado em string.
pub fn lista_string(lst: List(Float)) -> List(String) {
  mapeia(lst, float.to_string)
}

pub fn lista_string_examples() {
  check.eq(lista_string([3.0, 7.0]), ["3.0", "7.0"])
}
