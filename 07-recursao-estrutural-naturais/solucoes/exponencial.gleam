import sgleam/check

/// Calcula *a* elevado a *n*. Devolve Error(Nil) se *n* < 0.
pub fn exponencial(a: Float, n: Int) -> Result(Float, Nil) {
  case n {
    _ if n < 0 -> Error(Nil)
    0 -> Ok(1.0)
    _ ->
      case exponencial(a, n - 1) {
        Ok(p) -> Ok(a *. p)
        Error(e) -> Error(e)
      }
  }
}

pub fn exponencial_examples() {
  check.eq(exponencial(3.0, -1), Error(Nil))
  check.eq(exponencial(3.0, 0), Ok(1.0))
  check.eq(exponencial(3.0, 1), Ok(3.0))
  check.eq(exponencial(-2.0, 3), Ok(-8.0))
  check.eq(exponencial(0.5, 2), Ok(0.25))
  check.eq(exponencial(0.0, 0), Ok(1.0))
}
