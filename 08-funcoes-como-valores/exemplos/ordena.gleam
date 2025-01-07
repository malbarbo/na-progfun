import gleam/list
import sgleam/check

/// Cria uma lista com os elementos de *lst* em ordem não decrescente.
pub fn ordena(lst: List(Int)) -> List(Int) {
  list.fold(lst, [], insere_ordenado)
}

pub fn ordena_examples() {
  check.eq(ordena([]), [])
  check.eq(ordena([2]), [2])
  check.eq(ordena([3, 2]), [2, 3])
  check.eq(ordena([5, -2, 3]), [-2, 3, 5])
  check.eq(ordena([1, 9, 5, -2, 8, 3]), [-2, 1, 3, 5, 8, 9])
}

/// Devolve uma nova lst com os mesmos elementos de *lst* junto com *n* em
/// ordem não decrescente.
///
/// Requer que *lst* esteja em ordem não decrescente.
pub fn insere_ordenado(lst: List(Int), n: Int) -> List(Int) {
  case lst {
    [] -> [n]
    [primeiro, ..] if n < primeiro -> [n, ..lst]
    [primeiro, ..resto] -> [primeiro, ..insere_ordenado(resto, n)]
  }
}

pub fn insere_ordenado_examples() {
  check.eq(insere_ordenado([], 2), [2])
  check.eq(insere_ordenado([2], 1), [1, 2])
  check.eq(insere_ordenado([2], 3), [2, 3])
  check.eq(insere_ordenado([2, 6, 9], 1), [1, 2, 6, 9])
  check.eq(insere_ordenado([2, 6, 9], 4), [2, 4, 6, 9])
  check.eq(insere_ordenado([2, 6, 9], 7), [2, 6, 7, 9])
  check.eq(insere_ordenado([2, 6, 9], 10), [2, 6, 9, 10])
}
