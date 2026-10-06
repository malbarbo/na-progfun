import sgleam/check

/// Devolve Ok(True) se *n* é par, Ok(False) caso contrário.
/// Devolve Error(Nil) se *n* < 0.
pub fn par(n: Int) -> Result(Bool, Nil) {
  case n {
    _ if n < 0 -> Error(Nil)
    0 -> Ok(True)
    _ -> impar(n - 1)
  }
}

/// Devolve Ok(True) se *n* é ímpar, Ok(False) caso contrário.
/// Devolve Error(Nil) se *n* < 0.
pub fn impar(n: Int) -> Result(Bool, Nil) {
  case n {
    _ if n < 0 -> Error(Nil)
    0 -> Ok(False)
    _ -> par(n - 1)
  }
}

pub fn par_examples() {
  check.eq(par(-1), Error(Nil))
  check.eq(par(0), Ok(True))
  check.eq(par(1), Ok(False))
  check.eq(par(2), Ok(True))
  check.eq(par(3), Ok(False))
}

pub fn impar_examples() {
  check.eq(impar(-1), Error(Nil))
  check.eq(impar(0), Ok(False))
  check.eq(impar(1), Ok(True))
  check.eq(impar(2), Ok(False))
  check.eq(impar(3), Ok(True))
}
