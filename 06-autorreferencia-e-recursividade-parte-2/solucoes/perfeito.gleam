import sgleam/check

/// Produz True se *n* é perfeito, isto é, *n* positivo e a soma dos seus
/// divisores (menos ele mesmo) a *n*.
pub fn perfeito(n: Int) -> Bool {
  n > 0 && n == soma_divisores(n, n - 1)
}

/// Soma os divisores de `n` no intervalo [1, d].
pub fn soma_divisores(n: Int, d: Int) -> Int {
  case d <= 0 {
    True -> 0
    False ->
      case n % d == 0 {
        True -> d + soma_divisores(n, d - 1)
        False -> soma_divisores(n, d - 1)
      }
  }
}

pub fn perfeito_examples() {
  check.eq(perfeito(1), False)
  check.eq(perfeito(2), False)
  check.eq(perfeito(3), False)
  check.eq(perfeito(4), False)
  check.eq(perfeito(5), False)
  // 6 = 1 + 2 + 3
  check.eq(perfeito(6), True)
  check.eq(perfeito(27), False)
  // 28 = 1 + 2 + 4 + 7 + 14
  check.eq(perfeito(28), True)
  check.eq(perfeito(29), False)
}

pub fn soma_divisores_examples() {
  check.eq(soma_divisores(7, 1), 1)
  check.eq(soma_divisores(7, 0), 0)
  // 4 + 2 + 1
  check.eq(soma_divisores(4, 4), 7)
  // 5 + 2 + 1
  check.eq(soma_divisores(10, 9), 8)
}
