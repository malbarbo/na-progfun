import sgleam/check

/// Produz True se *n* é um número positivo de três dígitos.
pub fn tres_digitos(n: Int) -> Bool {
  100 <= n && n <= 999
}

pub fn tres_digitos_examples() {
  check.eq(tres_digitos(99), False)
  check.eq(tres_digitos(100), True)
  check.eq(tres_digitos(999), True)
  check.eq(tres_digitos(1000), False)
}
