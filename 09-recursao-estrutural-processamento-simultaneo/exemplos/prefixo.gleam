import sgleam/check

/// Devolve True se *lsta* é prefixo de *lstb*, isto é, os elementos de *lsta*
/// aparecem no início de *lstb*. Devolve False, caso contrário.
pub fn prefixo(lsta: List(a), lstb: List(a)) -> Bool {
  case lsta, lstb {
    [], _ -> True
    _, [] -> False
    [a, ..restoa], [b, ..restob] -> a == b && prefixo(restoa, restob)
  }
}

pub fn prefixo_examples() {
  // [], []
  check.eq(prefixo([], []), True)
  // [], [_, ..]
  check.eq(prefixo([], [3, 4]), True)
  // [_, ..], []
  check.eq(prefixo([3, 4], []), False)
  // [_, ..], [_, ..]
  check.eq(prefixo([3, 4], [3, 4]), True)
  check.eq(prefixo([3, 4], [3, 4, 6, 8]), True)
  check.eq(prefixo([3, 4], [3, 5]), False)
  check.eq(prefixo([3, 4, 5], [3, 4]), False)
}
