import sgleam/check

/// Cria uma lista com os valores a, a + 1, ..., b. Devolve a lista vazia se
/// b < a.
pub fn intervalo(a: Int, b: Int) -> List(Int) {
  case b {
    _ if b < a -> []
    _ if b == a -> [a]
    _ -> adiciona_fim(intervalo(a, b - 1), b)
  }
}

pub fn intervalo_examples() {
  check.eq(intervalo(3, 2), [])
  check.eq(intervalo(3, 3), [3])
  check.eq(intervalo(3, 5), [3, 4, 5])
  check.eq(intervalo(-2, 1), [-2, -1, 0, 1])
}

/// Adiciona *n* ao final de *lst*.
pub fn adiciona_fim(lst: List(a), n: a) -> List(a) {
  case lst {
    [] -> [n]
    [primeiro, ..resto] -> [primeiro, ..adiciona_fim(resto, n)]
  }
}

pub fn adiciona_fim_examples() {
  check.eq(adiciona_fim([], 3), [3])
  check.eq(adiciona_fim([3], 4), [3, 4])
  check.eq(adiciona_fim([3, 4], 1), [3, 4, 1])
  check.eq(adiciona_fim(["a"], "b"), ["a", "b"])
}
