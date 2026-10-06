import sgleam/check

/// Devolve o produto 1 * 2 * ... * *n*.
pub fn fatorial(n: Int) -> Int {
  case n {
    _ if n <= 0 -> 1
    _ -> n * fatorial(n - 1)
  }
}

pub fn fatorial_examples() {
  check.eq(fatorial(-1), 1)
  check.eq(fatorial(0), 1)
  check.eq(fatorial(1), 1)
  check.eq(fatorial(4), 24)
}
