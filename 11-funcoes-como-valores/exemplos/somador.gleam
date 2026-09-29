import sgleam/check

/// Devolve uma função que recebe um parâmetro *x* e faz a soma de *n* e *x*.
pub fn somador(n: Int) -> fn(Int) -> Int {
  fn(x) { n + x }
}

pub fn somador_examples() {
  check.eq(somador(4)(3), 7)
  check.eq(somador(-2)(8), 6)
}
