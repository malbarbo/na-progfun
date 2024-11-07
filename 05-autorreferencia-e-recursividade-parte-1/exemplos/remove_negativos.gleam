import sgleam/check

/// Produz uma nova lista removendo os valores negativos de *lst*.
pub fn remove_negativos(lst: List(Int)) -> List(Int) {
  case lst {
    [] -> []
    [primeiro, ..resto] if primeiro < 0 -> remove_negativos(resto)
    [primeiro, ..resto] -> [primeiro, ..remove_negativos(resto)]
  }
}

pub fn remove_negativos_examples() {
  check.eq(remove_negativos([]), [])
  check.eq(remove_negativos([-1, 2, -3]), [2])
  check.eq(remove_negativos([3, 4, -2]), [3, 4])
}
