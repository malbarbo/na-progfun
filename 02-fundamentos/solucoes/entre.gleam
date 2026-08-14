import sgleam/check

/// Produz True se *x* está entre *a* e *b*, incluindo os extremos.
pub fn entre(a: Int, x: Int, b: Int) -> Bool {
  a <= x && x <= b
}

pub fn entre_examples() {
  check.eq(entre(2, 5, 8), True)
  check.eq(entre(2, 2, 8), True)
  check.eq(entre(2, 9, 8), False)
}
