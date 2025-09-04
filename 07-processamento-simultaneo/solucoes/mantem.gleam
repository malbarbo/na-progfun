import sgleam/check

/// Devolve uma lista com os *n* primeiros elementos de *lst*. Se *n* é maior
/// do que a quantidade de elementos de *lst*, devolve *lst*. Se *n* é
/// negativo, devolve [].
pub fn mantem(lst: List(a), n: Int) -> List(a) {
  case lst {
    [primeiro, ..resto] if n > 0 -> [primeiro, ..mantem(resto, n - 1)]
    _ -> []
  }
}

pub fn mantem_examples() {
  check.eq(mantem([], -1), [])
  check.eq(mantem([], 0), [])
  check.eq(mantem([], 1), [])
  check.eq(mantem([1, 2, 3], -1), [])
  check.eq(mantem([1, 2, 3], 0), [])
  check.eq(mantem([1, 2, 3], 1), [1])
  check.eq(mantem([1, 2, 3], 2), [1, 2])
  check.eq(mantem([1, 2, 3], 12), [1, 2, 3])
}
