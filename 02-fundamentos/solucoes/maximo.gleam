import sgleam/check

/// Devolve o valor máximo entre *a* e *b*.
pub fn maximo(a: Int, b: Int) -> Int {
  case a >= b {
    True -> a
    False -> b
  }
}

pub fn maximo_examples() {
  check.eq(maximo(3, 5), 5)
  check.eq(maximo(8, 4), 8)
  check.eq(maximo(6, 6), 6)
}
