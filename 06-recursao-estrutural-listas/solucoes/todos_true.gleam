import sgleam/check

/// Produz True se todos os elementos de *lst* são True ou se *lst* é vazia,
/// produz False caso contrário.
pub fn todos_true(lst: List(Bool)) -> Bool {
  case lst {
    [] -> True
    [primeiro, ..resto] -> primeiro && todos_true(resto)
  }
}

pub fn todos_true_examples() {
  check.eq(todos_true([]), True)
  check.eq(todos_true([False]), False)
  check.eq(todos_true([True]), True)
  check.eq(todos_true([True, False]), False)
  check.eq(todos_true([True, True]), True)
  check.eq(todos_true([True, True, True]), True)
}
