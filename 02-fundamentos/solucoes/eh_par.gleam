import sgleam/check

/// Produz True se *n* é par.
pub fn eh_par(n: Int) -> Bool {
  n % 2 == 0
}

pub fn eh_par_examples() {
  check.eq(eh_par(3), False)
  check.eq(eh_par(6), True)
}
