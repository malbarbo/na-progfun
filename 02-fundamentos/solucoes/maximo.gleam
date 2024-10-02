import sgleam.{check_equal}

/// Devolve o valor máximo entre *a* e *b*.
pub fn maximo(a: Int, b: Int) -> Int {
  case a >= b {
    True -> a
    False -> b
  }
}

pub fn maximo_examples() {
  check_equal(maximo(3, 5), 5)
  check_equal(maximo(8, 4), 8)
  check_equal(maximo(6, 6), 6)
}
