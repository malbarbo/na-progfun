import sgleam/check

/// Devolve True se *a* é par, False caso contrário.
pub fn par(a: Int) -> Bool {
  case a {
    _ if a < 0 -> impar(a + 1)
    _ if a == 0 -> True
    _ -> impar(a - 1)
  }
}

/// Devolve True se *a* é ímpar, False caso contrário.
pub fn impar(a: Int) -> Bool {
  case a {
    _ if a < 0 -> par(a + 1)
    _ if a == 0 -> False
    _ -> par(a - 1)
  }
}

pub fn par_examples() {
  check.eq(par(-3), False)
  check.eq(par(-2), True)
  check.eq(par(-1), False)
  check.eq(par(0), True)
  check.eq(par(1), False)
  check.eq(par(2), True)
  check.eq(par(3), False)
}

pub fn impar_examples() {
  check.eq(impar(-3), True)
  check.eq(impar(-2), False)
  check.eq(impar(-1), True)
  check.eq(impar(0), False)
  check.eq(impar(1), True)
  check.eq(impar(2), False)
  check.eq(impar(3), True)
}
