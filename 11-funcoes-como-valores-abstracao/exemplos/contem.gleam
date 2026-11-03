import sgleam/check

/// Devolve True se *n* está em *lst*, False caso contrário.
pub fn contem(lst: List(Int), n: Int) -> Bool {
  case lst {
    [] -> False
    [primeiro, ..resto] -> primeiro == n || contem(resto, n)
  }
}

pub fn contem_examples() {
  check.eq(contem([], 3), False)
  check.eq(contem([3], 3), True)
  check.eq(contem([5], 8), False)
  check.eq(contem([3, -4, 5, 9, 10], 5), True)
  check.eq(contem([2, -5, -2], 5), False)
}

/// Devolve True se 3 está em *lst*, False caso contrário.
pub fn contem_3(lst: List(Int)) -> Bool {
  contem(lst, 3)
}

pub fn contem_3_examples() {
  check.eq(contem_3([]), False)
  check.eq(contem_3([3]), True)
  check.eq(contem_3([5]), False)
  check.eq(contem_3([3, -4, 5, 9, 10]), True)
  check.eq(contem_3([2, -5, -2]), False)
}

/// Devolve True se 5 está em *lst*, False caso contrário.
pub fn contem_5(lst: List(Int)) -> Bool {
  contem(lst, 5)
}

pub fn contem_5_examples() {
  check.eq(contem_5([]), False)
  check.eq(contem_5([3]), False)
  check.eq(contem_5([5]), True)
  check.eq(contem_5([3, -4, 5, 9, 10]), True)
  check.eq(contem_5([2, -5, -2]), False)
}
