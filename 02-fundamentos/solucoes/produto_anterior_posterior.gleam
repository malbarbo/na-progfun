import sgleam.{check_equal}

/// Calcula o produto de *n*, *n - 1* e *n + 1*.
pub fn produto_anterior_posterior(n: Int) -> Int {
  n * { n + 1 } * { n - 1 }
}

pub fn produto_anterior_posterior_examples() {
  check_equal(produto_anterior_posterior(3), 24)
  check_equal(produto_anterior_posterior(1), 0)
  check_equal(produto_anterior_posterior(-2), -6)
}
