import sgleam/check

/// Devolve uma função que recebe um parâmetro *x* e faz a soma de *n* e *x*.
pub fn soma(n: Int) -> fn(Int) -> Int {
  fn(x) { n + x }
}

pub fn soma_examples() {
  check.eq(soma(4)(3), 7)
  check.eq(soma(-2)(8), 6)
}
