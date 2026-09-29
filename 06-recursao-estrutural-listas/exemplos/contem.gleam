import sgleam/check

// Produz True se *v* está em *lst*, False caso contrário.
pub fn contem(lst: List(a), v: a) -> Bool {
  case lst {
    [] -> False
    [primeiro, ..resto] -> primeiro == v || contem(resto, v)
  }
}

pub fn contem_examples() {
  check.eq(contem([], 3), False)
  check.eq(contem([3], 3), True)
  check.eq(contem([3], 4), False)
  check.eq(contem([4, 10, 3], 4), True)
  check.eq(contem([4, 10, 3], 10), True)
  check.eq(contem([4, 10, 3], 8), False)
}
