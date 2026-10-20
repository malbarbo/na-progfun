import sgleam/check

/// Produz True se *n* é um quadrado perfeito, isto é, existe um número natural
/// *i* tal que *i* * *i* = *n*. Produz False caso contrário.
pub fn quadrado_perfeito(n: Int) -> Bool {
  existe_raiz(n, n)
}

pub fn quadrado_perfeito_examples() {
  check.eq(quadrado_perfeito(0), True)
  check.eq(quadrado_perfeito(1), True)
  check.eq(quadrado_perfeito(2), False)
  check.eq(quadrado_perfeito(3), False)
  check.eq(quadrado_perfeito(4), True)
  check.eq(quadrado_perfeito(8), False)
  check.eq(quadrado_perfeito(9), True)
  check.eq(quadrado_perfeito(10), False)
}

/// Produz True se existe um número natural *i* <= *a* tal que *i* * *i* = *n*.
/// Produz False caso contrário.
pub fn existe_raiz(n: Int, a: Int) -> Bool {
  case a {
    _ if a <= 0 -> n == 0
    _ -> a * a == n || existe_raiz(n, a - 1)
  }
}

pub fn existe_raiz_examples() {
  check.eq(existe_raiz(0, 0), True)
  check.eq(existe_raiz(9, 0), False)
  check.eq(existe_raiz(9, 1), False)
  check.eq(existe_raiz(9, 2), False)
  check.eq(existe_raiz(9, 3), True)
}
