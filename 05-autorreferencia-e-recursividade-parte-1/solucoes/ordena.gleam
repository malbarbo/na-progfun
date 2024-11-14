import sgleam/check

/// Cria uma lista com os elementos de *lst* em ordem não decrescente usando o
/// algoritmo de ordenação por inserção.
pub fn ordena(lst: List(Int)) -> List(Int) {
  case lst {
    [] -> []
    [primeiro, ..resto] -> insere_ordenado(ordena(resto), primeiro)
  }
}

pub fn ordena_examples() {
  check.eq(ordena([]), [])
  check.eq(ordena([2]), [2])
  check.eq(ordena([3, 2]), [2, 3])
  check.eq(ordena([5, -2, 3]), [-2, 3, 5])
  check.eq(ordena([1, 9, 5, -2, 8, 3]), [-2, 1, 3, 5, 8, 9])
}

/// Devolve uma nova lista com os mesmos elementos de lst junto com n em ordem
/// não decrescente.
///
/// Requer que lst esteja em ordem não decrescente.
fn insere_ordenado(lst: List(Int), n: Int) -> List(Int) {
  case lst {
    [] -> [n]
    [primeiro, ..resto] if n < primeiro -> [n, primeiro, ..resto]
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
