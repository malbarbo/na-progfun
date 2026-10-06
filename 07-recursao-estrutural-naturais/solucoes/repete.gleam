import sgleam/check

/// Cria uma lista com *n* repetições de *v*.
pub fn repete(n: Int, v: a) -> List(a) {
  case n {
    _ if n <= 0 -> []
    _ -> [v, ..repete(n - 1, v)]
  }
}

pub fn repete_examples() {
  check.eq(repete(-1, "a"), [])
  check.eq(repete(0, "a"), [])
  check.eq(repete(1, "a"), ["a"])
  check.eq(repete(3, 5), [5, 5, 5])
}
