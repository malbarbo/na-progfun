import sgleam/check

/// Produz True se *n* é um número primo, isto é, tem exatamente dois divisores
/// distintos (1 e *n*). Produz False caso contrário.
pub fn primo(n: Int) -> Bool {
  num_divisors(n, n) == 2
}

fn num_divisors(n: Int, a: Int) -> Int {
  case a {
    _ if a <= 0 -> 0
    _ if n % a == 0 -> 1 + num_divisors(n, a - 1)
    _ -> num_divisors(n, a - 1)
  }
}

pub fn primo_examples() {
  check.eq(primo(1), False)
  check.eq(primo(2), True)
  check.eq(primo(3), True)
  check.eq(primo(4), False)
  check.eq(primo(5), True)
  check.eq(primo(6), False)
  check.eq(primo(7), True)
  check.eq(primo(8), False)
}
