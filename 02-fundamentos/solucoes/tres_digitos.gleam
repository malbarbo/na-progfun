import sgleam.{check_equal}

/// Produz True se *n* é um número positivo de três digitos.
pub fn tres_digitos(n: Int) -> Bool {
  100 <= n && n <= 999
}

pub fn tres_digitos_examples() {
  check_equal(tres_digitos(99), False)
  check_equal(tres_digitos(100), True)
  check_equal(tres_digitos(999), True)
  check_equal(tres_digitos(1000), False)
}
