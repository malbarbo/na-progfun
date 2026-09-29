import sgleam/check

/// Cria uma lista com os valores 1, 2, ..., n-1, n.
pub fn lista_num(n: Int) -> List(Int) {
  case n {
    _ if n <= 0 -> []
    _ -> adiciona_fim(lista_num(n - 1), n)
  }
}

pub fn lista_num_examples() {
  check.eq(lista_num(0), [])
  check.eq(lista_num(1), [1])
  check.eq(lista_num(2), [1, 2])
  check.eq(lista_num(3), [1, 2, 3])
}

/// Adiciona *n* ao final de *lst*.
pub fn adiciona_fim(lst: List(Int), n: Int) -> List(Int) {
  case lst {
    [] -> [n]
    [primeiro, ..resto] -> [primeiro, ..adiciona_fim(resto, n)]
  }
}

pub fn adiciona_fim_examples() {
  check.eq(adiciona_fim([], 3), [3])
  check.eq(adiciona_fim([3], 4), [3, 4])
  check.eq(adiciona_fim([3, 4], 1), [3, 4, 1])
}
