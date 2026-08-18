import sgleam/check

/// Produz True se os elementos de *lst* estão em ordem não decrescente,
/// produz False caso contrário.
pub fn ordenado(lst: List(Int)) -> Bool {
  case lst {
    [] | [_] -> True
    [primeiro, segundo, ..resto] ->
      primeiro <= segundo && ordenado([segundo, ..resto])
  }
}

pub fn ordenado_examples() {
  check.eq(ordenado([]), True)
  check.eq(ordenado([4]), True)
  check.eq(ordenado([3, 4]), True)
  check.eq(ordenado([5, 4]), False)
  check.eq(ordenado([3, 3, 4]), True)
  check.eq(ordenado([3, 5, 4]), False)
}
